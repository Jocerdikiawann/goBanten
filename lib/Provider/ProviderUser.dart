import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gobanten/Screens/ScreensHome.dart';
import 'package:gobanten/Utils/ApiService.dart';
import 'package:gobanten/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier, DiagnosticableTreeMixin {
  Color colors;
  String _errorMessage;
  bool _isLoading = false;
  UserModel _userModel = UserModel();
  bool get isloading => _isLoading;
  UserModel get usermodel => _userModel;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> setUserModel(UserModel user) async {
    this._userModel = user;
    final sharedPref = await SharedPreferences.getInstance();
    final myPref = json.encode({
      'email': user.email,
      'token': user.idToken,
      'localId': user.localId,
      'name': user.name
    });
    sharedPref.setString('loginData', myPref);

    notifyListeners();
  }

  notifFlushbar(BuildContext context, String message, Color color) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      backgroundColor: color,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 5),
    )..show(context);
    notifyListeners();
  }

  void handleExceptionLogin(BuildContext context, status) {
    if (status['error'] != null) {
      var errorM = status['error']['message'];
      if (errorM == 'EMAIL_NOT_FOUND') {
        _errorMessage = 'Emailnya salah';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM == 'INVALID_PASSWORD') {
        _errorMessage = 'Passwordnya salah';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM == 'INVALID_EMAIL') {
        _errorMessage = 'Gunakan format email ya!';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM == 'USER_DISABLED') {
        _errorMessage = 'Akun telah di matikan oleh admin';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM ==
          'TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.') {
        _errorMessage =
            "Yah,Kami telah memblokir semua permintaan dari perangkat ini karena aktivitas yang tidak biasa. Coba lagi nanti.";
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
    }
    notifyListeners();
  }

  void handleExceptionRegister(BuildContext context, status) {
    if (status['error'] != null) {
      var errorM = status['error']['message'];
      if (errorM == 'EMAIL_EXISTS') {
        _errorMessage = 'Emailnya sudah terdaftar';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM == 'OPERATION_NOT_ALLOWED') {
        _errorMessage = 'Masuk dengan sandi dinonaktifkan untuk proyek ini!';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM == 'MISSING_PASSWORD') {
        _errorMessage = 'Password invalid nih!';
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
      if (errorM ==
          'TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.') {
        _errorMessage =
            "Yah,Kami telah memblokir semua permintaan dari perangkat ini karena aktivitas yang tidak biasa. Coba lagi nanti.";
        colors = Colors.red;
        return notifFlushbar(context, _errorMessage, colors);
      }
    }
    notifyListeners();
  }

  Future<void> register(
      BuildContext context, String email, name, password) async {
    setLoading(true);
    try {
      return await http
          .post(
        ApiService().signUpUrl,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      )
          .then((value) {
        setLoading(false);
        var responseData = json.decode(value.body);
        handleExceptionRegister(context, responseData);
        if (value.statusCode == 200) {
          http.put(
            ApiService().storeData(responseData['localId']),
            body: json.encode(
              {
                'token': responseData['idToken'],
                'id': responseData['localId'],
                'email': responseData['email'],
                'name': name,
              },
            ),
          );
          notifFlushbar(
              context, "Yey, Pendaftaran berhasil berhasil!", Colors.green);
          print('Berhasil Register');
        }
        print('Data error register : ${responseData['error']['message']}');
      });
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> login(String email, password, BuildContext context) async {
    setLoading(true);
    try {
      return await http
          .post(
        ApiService().signinUrl,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      )
          .then((value) async {
        setLoading(false);
        var responseData = json.decode(value.body);
        print('Uid : ${responseData['uid']}');
        handleExceptionLogin(context, responseData);
        if (value.statusCode == 200) {
          await http
              .get(
            ApiService().getData(
              responseData['localId'],
            ),
          )
              .then(
            (response) {
              var data = json.decode(response.body);
              var dataku = data[responseData['localId']];
              print('Ini Dataku : $dataku');
              setUserModel(new UserModel(
                email: dataku['email'],
                idToken: dataku['token'],
                localId: dataku['id'],
                name: dataku['name'],
              ));
            },
          );
          notifFlushbar(context, "Yey, Login berhasil!", Colors.green);
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScreensHome(),
            ),
          );
        }
      });
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  Future<bool> autoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('loginData')) {
      return false;
    }
    final myData = json.decode(pref.get('loginData')) as Map<String, dynamic>;
    setUserModel(
      new UserModel(
        email: myData['email'],
        idToken: myData['token'],
        localId: myData['localId'],
        name: myData['name'],
      ),
    );
    return true;
  }

  Future logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }
}

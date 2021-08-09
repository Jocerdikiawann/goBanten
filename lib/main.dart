import 'package:flutter/material.dart';
import 'package:gobanten/Provider/ProviderUser.dart';
import 'package:gobanten/Screens/Login/login_screen.dart';
import 'package:gobanten/Screens/ScreensHome.dart';
import 'package:gobanten/Screens/Welcome/welcome_screen.dart';
import 'package:gobanten/Utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider<AuthService>.value(value: AuthService()),
          ChangeNotifierProvider(
            create: (_) => AuthService(),
          ),
        ],
        child: Consumer<AuthService>(
          builder: (_, a, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'GoBanten',
                theme: ThemeData(
                  primaryColor: kPrimaryColor,
                  scaffoldBackgroundColor: Colors.white,
                ),
                home: FutureBuilder(
                    future: a.autoLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print('Has data : ${snapshot.hasData}');
                        if (!snapshot.data) {
                          return WelcomeScreen();
                        } else {
                          return ScreensHome();
                        }
                      } else {
                        print('Has data : ${snapshot.hasData}');
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }));
          },
        ));
  }
}

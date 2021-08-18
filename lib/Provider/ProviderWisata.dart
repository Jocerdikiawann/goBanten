import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gobanten/Utils/ApiService.dart';
import 'package:gobanten/models/WisataModel.dart';
import 'package:http/http.dart' as http;

class ProviderWisata with ChangeNotifier, DiagnosticableTreeMixin {
  List<Wisata> _wisata = [];

  List<Wisata> get wisata => _wisata;

  void setWisata(Wisata value) {
    this._wisata.add(value);
    notifyListeners();
  }

  Future getWisata() async {
    try {
      var response = await http.get(ApiService().getWisata);
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }
}

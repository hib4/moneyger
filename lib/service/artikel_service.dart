import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:moneyger/model/artikel_model.dart';

class ArtikelServiceClass {
  Future<List> getservice() async {
    List artikel = [];
    String json = await rootBundle.loadString("assets/data/artikel.json");

    List datajson = jsonDecode(json);

    datajson.map((value) {
      artikel.add(ArtikelModel.fromJson(value));
    }).toList();
    return artikel;
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class DataBase {
  // reference the hive box
  final _box = Hive.box('box');

  int documentID = 1;
  String documentName = "Nouveau Document";
  String prositUrl = "";
  String prositTitle = "";
  List<String> keyWords = [];
  String stringContext = "";
  List<String> problems = [];
  List<String> constraints = [];
  List<String> deliverables = [];
  List<String> generalisings = [];
  List<String> hypothesises = [];
  List<String> solutions = [];
  List<String> actions = [];

  late List a = [
    documentName,
    prositUrl,
    prositTitle,
    keyWords,
    stringContext,
    problems,
    constraints,
    deliverables,
    generalisings,
    hypothesises,
    solutions,
    actions,
  ];

  void createInitialData() {
    documentName = "Nouveau Document";
    prositUrl = "";
    prositTitle = "";
    keyWords = [];
    stringContext = "";
    problems = [];
    constraints = [];
    deliverables = [];
    generalisings = [];
    hypothesises = [];
    solutions = [];
    actions = [];
  }

  void saveData() {
    _box.put(documentID, a);
  }

  void loadData() {
    if (_box.containsKey(documentID)) {
      List b = _box.get(documentID);
      for (int i = 0; i < b.length; i++) {
        a[i] = b[i];
      }
    } else {
      createInitialData();
    }
  }

  int getTheNextKey() {
    int index = 0;
    while (true) {
      if (!_box.containsKey(index)) {
        return index;
      } else {
        index++;
      }
    }
    /*if (_box.length == 0) {
      return 0;
    } else {
      return _box.keyAt(_box.length - 1) + 1;
    }*/
  }
}

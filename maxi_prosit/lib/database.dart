import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class DataBase {
//Private
  // reference the hive box
  final _box = Hive.box('box');

  int documentID;

  DataBase(this.documentID) {
    _loadData();
  }

  String _documentName = "";
  String _prositUrl = "";
  String _prositTitle = "";

  late List<String> _informations = [_documentName, _prositTitle, _prositUrl];
  List<String> _keyWords = [];
  List<String> _contexts = [];
  List<String> _problems = [];
  List<String> _constraints = [];
  List<String> _deliverables = [];
  List<String> _generalisings = [];
  List<String> _hypothesises = [];
  List<String> _solutions = [];
  List<String> _actions = [];

  void _loadData() {
    if (_box.containsKey(documentID)) {
      List list = _box.get(documentID);
      _informations = list[0];
      _keyWords = list[1];
      _contexts = list[2];
      _problems = list[3];
      _constraints = list[4];
      _deliverables = list[5];
      _generalisings = list[6];
      _hypothesises = list[7];
      _solutions = list[8];
      _actions = list[9];
    } else {
      _createInitialData();
    }
  }

  void _createInitialData() {
    _documentName = "Nouveau Document";
    _prositUrl = "";
    _prositTitle = "";
    _keyWords = [];
    _contexts = [];
    _problems = [];
    _constraints = [];
    _deliverables = [];
    _generalisings = [];
    _hypothesises = [];
    _solutions = [];
    _actions = [];
  }

// Public
  void saveData() {
    _box.put(documentID, a);
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
  }

  late List a = [
    _informations,
    _keyWords,
    _contexts,
    _problems,
    _constraints,
    _deliverables,
    _generalisings,
    _hypothesises,
    _solutions,
    _actions,
  ];
}

import 'package:flutter/material.dart';

class Vol extends ChangeNotifier {
  final List<Map<String, Object>> _vols = [
    {
      'name': 'mahmoud',
      'phone': '01027900425',
      'state': 'بنها',
      'id': '1',
    },
    {
      'name': 'mahmoud',
      'phone': '01027900425',
      'state': 'بنها',
      'id': '2',
    },
    {
      'name': 'mahmoud',
      'phone': '01027900425',
      'state': 'بنها',
      'id': '3',
    },
    {
      'name': 'mahmoud',
      'phone': '01027900425',
      'state': 'بنها',
      'id': '4',
    }
  ];
  List<Map<String, Object>> get vols {
    return _vols;
  }

  void addVol(Map<String, Object> vol) {
    _vols.add(vol);
    notifyListeners();
  }
}

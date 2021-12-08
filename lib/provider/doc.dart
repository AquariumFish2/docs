import 'package:flutter/cupertino.dart';

class Doc extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<String, Object>> _doctors = [];

  List<Map<String, Object>> get doctors {
    return _doctors;
  }

  void add(Map<String, Object> newDoctor) {
    newDoctor['patients'] = [];
    _doctors.add(newDoctor);
    notifyListeners();
  }

  void delete(String id) {
    _doctors.removeWhere((element) => element['id'] == id);
  }
}

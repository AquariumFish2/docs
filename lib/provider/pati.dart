import 'package:flutter/cupertino.dart';

class PatientProv extends ChangeNotifier {
  final List<Map<String, Object>> _patients = [];

  List<Map<String, Object>> get patients {
    return _patients;
  }

  void addPatient(Map<String, Object> newPatient) {
    _patients.add(newPatient);
    notifyListeners();
  }
}

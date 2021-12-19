import 'package:flutter/material.dart';

class StateManagment extends ChangeNotifier {
  String? userDropDownBottonValue;
  void setUserDropDownBottonValue(String v) {
    userDropDownBottonValue = v;
    notifyListeners();
  }
}

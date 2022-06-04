import 'package:flutter/cupertino.dart';

class SettinsgState extends ChangeNotifier {
  bool emailClicked = false;

  emailTap(bool value) {
    emailClicked = value;

    notifyListeners();
  }
}

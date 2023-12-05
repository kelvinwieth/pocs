import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {
  void showSnack(String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(this).showSnackBar(snackbar);
  }
}

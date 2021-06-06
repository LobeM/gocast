import 'package:flutter/material.dart';

enum FormFieldType {
  normal,
  email,
  password,
  phone,
  date,
}

/// Various form utils.
class FormUtils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

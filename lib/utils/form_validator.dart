import 'package:flutter/material.dart';

/// Form validator class.
class FormValidator {
  /// Validator that requires the field have a non-empty value.
  static FormFieldValidator<String> isRequired(String errorMessage) {
    return (String value) {
      return value.isEmpty ? errorMessage : null;
    };
  }

  /// Validator that requires the field's value pass an email validation test.
  ///
  /// This validator uses Regex of HTML5 email validator.
  ///
  /// ```dart
  /// RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  /// ```
  static FormFieldValidator<String> isEmail(String errorMessage) {
    return (String value) {
      if (value.isEmpty)
        return null;
      else {
        final RegExp emailRegex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        return emailRegex.hasMatch(value) ? null : errorMessage;
      }
    };
  }

  /// Validator that requires the length of the field's value to be greater than
  /// or equal to the provided minimum length.
  static FormFieldValidator<String> isMinLength(
      {int length, String errorMessage}) {
    return (String value) {
      return value.length < length ? errorMessage : null;
    };
  }

  /// Validator that requires the length of the field's value to be less or
  /// equal to the provided maximum length.
  static FormFieldValidator<String> isMaxLength(
      {int length, String errorMessage}) {
    return (String value) {
      return value.length > length ? errorMessage : null;
    };
  }

  /// Validator that requires the field's value to match the regex string.
  static FormFieldValidator<String> matchesRegex(
      {String regex, String errorMessage}) {
    return (String value) {
      return RegExp(regex).hasMatch(value) ? null : errorMessage;
    };
  }

  /// Compose multiple validators into a single validator.
  ///
  /// ```dart
  ///            FormValidator.compose([
  ///              FormValidator.required('Compose is required'),
  ///              FormValidator.minLength(5, 'Characters cannot be less than 5'),
  ///              FormValidator.maxLength(10, 'Characters cannot be greater than 10'),
  ///            ]),
  /// ```
  ///
  static FormFieldValidator<String> validators(
      List<FormFieldValidator<String>> validators) {
    return (String value) {
      for (final FormFieldValidator<String> validator in validators) {
        final String result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}

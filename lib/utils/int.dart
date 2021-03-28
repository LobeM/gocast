import 'package:flutter/material.dart';
import 'package:gocast/generated/l10n.dart';

/// [int] extensions.
extension IntExtension on int {
  String toDuration(BuildContext context) {
    if (this > 60) {
      final int hours = (this / 60).floor();
      final int mins = this % 60;
      return L10n.of(context).commonDurationHourMin(hours, mins);
    }
    if (this == 60) {
      return L10n.of(context).commonDurationHours(this);
    }
    return L10n.of(context).commonDurationMins(this);
  }
}

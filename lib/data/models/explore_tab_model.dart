import 'package:flutter/material.dart';

class ExploreTabModel {
  ExploreTabModel(
    this.id,
    this.globalKey,
    this.label,
  );

  factory ExploreTabModel.fromJson(Map<String, dynamic> json) {
    return ExploreTabModel(
      json['id'] as int ?? 0,
      json['globalKey'],
      json['label'] as String ?? '',
    );
  }

  final int id;
  final GlobalKey globalKey;
  final String label;
}

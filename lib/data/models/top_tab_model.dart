import 'package:flutter/material.dart';

class TopTabModel {
  TopTabModel(
    this.id,
    this.globalKey,
    this.label,
  );

  factory TopTabModel.fromJson(Map<String, dynamic> json) {
    return TopTabModel(
      json['id'] as int ?? 0,
      json['globalKey'],
      json['label'] as String ?? '',
    );
  }

  final int id;
  final GlobalKey globalKey;
  final String label;
}

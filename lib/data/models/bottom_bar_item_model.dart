import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomBarItemModel extends Equatable {
  const BottomBarItemModel({
    this.id,
    this.icon,
  });

  final String id;
  final IconData icon;

  @override
  List<Object> get props => <String>[id];
}

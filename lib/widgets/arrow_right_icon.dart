import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/main.dart';

/// [Icon] used in lists.
class ArrowRightIcon extends StatelessWidget {
  const ArrowRightIcon({
    Key key,
    this.size = 30,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      getIt.get<AppGlobals>().isRTL
          ? Icons.keyboard_arrow_left
          : Icons.keyboard_arrow_right,
      size: size,
    );
  }
}

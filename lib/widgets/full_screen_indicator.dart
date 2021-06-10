import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';

class FullScreenIndicator extends StatelessWidget {
  const FullScreenIndicator({
    Key key,
    this.color = kWhite,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: color,
          ),
        ),
      ),
    );
  }
}

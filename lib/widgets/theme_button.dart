import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/widgets/strut_text.dart';

/// General purpose [ElevatedButton] using app theme colors.
class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key key,
    this.onPressed,
    this.text,
    this.showLoading = false,
    this.disableTouchWhenLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool showLoading;
  final bool disableTouchWhenLoading;

  Widget _buildLoading() {
    if (!showLoading) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPaddingS),
      width: 14,
      height: 14,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disableTouchWhenLoading && showLoading ? null : onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StrutText(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.button.white.fs16.w500,
          ),
          _buildLoading()
        ],
      ),
    );
  }
}

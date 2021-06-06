import 'package:flutter/material.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/widgets/strut_text.dart';

/// Text button (Button without background).
class LinkButton extends StatelessWidget {
  const LinkButton({
    Key key,
    @required this.label,
    this.trailing,
    this.onPressed,
    this.style,
    this.padding,
    this.showLoading = false,
    this.disableTouchWhenLoading = false,
  }) : super(key: key);

  final String label;
  final Widget trailing;
  final VoidCallback onPressed;
  final TextStyle style;
  final EdgeInsetsDirectional padding;
  final bool showLoading;
  final bool disableTouchWhenLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disableTouchWhenLoading && showLoading ? null : onPressed,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: padding ?? const EdgeInsets.all(0),
              child: StrutText(
                label,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .button
                        .fs16
                        .copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            trailing ?? Container()
          ],
        ),
      ),
    );
  }
}

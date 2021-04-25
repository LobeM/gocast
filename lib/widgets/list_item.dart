import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/string.dart';

/// A single item in the collection of options.
///
/// Item may contain trailing and leading Widgets.
class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.showBorder = true,
  }) : super(key: key);

  /// Item title label.
  final String title;

  /// An optional item subtitle.
  final String subtitle;

  /// Item's optional leading [Widget].
  final Widget leading;

  /// Item's optional  trailing [Widget].
  final Widget trailing;

  /// Item tap callback function.
  final VoidCallback onPressed;

  /// Show bottom border? Default is true.
  final bool showBorder;

  /// Optional title text style.
  final TextStyle titleTextStyle;

  /// Optional subtitle text style.
  final TextStyle subtitleTextStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leading != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: kPaddingS),
                child: leading,
              )
            else
              Container(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StrutText(
                      title,
                      style: titleTextStyle ??
                          Theme.of(context).textTheme.subtitle1.fs18,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle?.isNotNullOrEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: StrutText(
                          subtitle,
                          style: subtitleTextStyle ??
                              Theme.of(context).textTheme.caption.fs14,
                          maxLines: 10,
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: kPaddingM),
                child: trailing,
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}

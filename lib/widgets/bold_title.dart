import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';

/// Bold title.
///
/// Used on [HomeScreen].
class BoldTitle extends StatelessWidget {
  const BoldTitle({
    Key key,
    this.title,
    this.onNavigate,
    this.padding,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  final String title;
  final VoidCallback onNavigate;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsetsDirectional.only(
            start: kPaddingM,
            end: kPaddingS,
            top: kPaddingL,
            bottom: kPaddingM,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: StrutText(
              title,
              style: Theme.of(context).textTheme.headline5.w600,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign ?? TextAlign.start,
            ),
          ),
          if (onNavigate != null)
            InkWell(
              child: const Icon(
                Icons.navigate_next,
                size: 32,
              ),
              onTap: onNavigate,
            )
        ],
      ),
    );
  }
}

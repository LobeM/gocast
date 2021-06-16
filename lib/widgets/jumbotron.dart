import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/widgets/strut_text.dart';

/// Widget for showcasing hero unit style content.
class Jumbotron extends StatelessWidget {
  const Jumbotron({
    Key key,
    this.title,
    this.icon,
    this.padding,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    EdgeInsets _padding;

    if (padding == null) {
      _padding = const EdgeInsets.only(top: kPaddingL);
    } else {
      _padding = padding;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: _padding,
          child: Icon(
            icon ?? Icons.info,
            size: 128,
            color: Theme.of(context).highlightColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: StrutText(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .bold
                .fs18
                .copyWith(color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

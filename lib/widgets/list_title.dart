import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';

/// Listing title.
///
/// Used alongside [ListItem].
class ListTitle extends StatelessWidget {
  const ListTitle({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingL, bottom: kPaddingS),
      child: Row(
        children: <Widget>[
          StrutText(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .w400
                .copyWith(color: Theme.of(context).hintColor),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

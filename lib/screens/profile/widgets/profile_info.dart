import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/widgets/initials_circle_avatar.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/string.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: kPaddingM)),
                  StrutText(
                    'Lobe Musonda',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline5.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  StrutText(
                    'lobe@email.com',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption.fs14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          InitialsCircleAvatar(
            initials: 'Lobe Musonda'.initials,
            size: InitialsCircleAvatarSize.small,
          ),
          SizedBox(width: kPaddingM)
        ],
      ),
    );
  }
}

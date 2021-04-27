import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/main.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/widgets/strut_text.dart';

enum InitialsCircleAvatarSize { small, large }

class InitialsCircleAvatar extends StatelessWidget {
  final String initials;
  final InitialsCircleAvatarSize size;

  const InitialsCircleAvatar({
    Key key,
    this.initials,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmall = size == InitialsCircleAvatarSize.small;

    TextStyle textStyle;

    if (isSmall) {
      textStyle = getIt.get<AppGlobals>().isPlatformBrightnessDark
          ? Theme.of(context)
              .textTheme
              .subtitle1
              .bold
              .copyWith(color: kWhite.withAlpha(128))
          : Theme.of(context).textTheme.subtitle1.bold.white;
    } else {
      textStyle = getIt.get<AppGlobals>().isPlatformBrightnessDark
          ? Theme.of(context)
              .textTheme
              .headline3
              .bold
              .copyWith(color: kWhite.withAlpha(128))
          : Theme.of(context).textTheme.headline3.bold.white;
    }

    return CircleAvatar(
      radius:
          isSmall ? kCircleAvatarSizeRadiusSmall : kCircleAvatarSizeRadiusLarge,
      backgroundColor: getIt.get<AppGlobals>().isPlatformBrightnessDark
          ? kWhite.withAlpha(20)
          : kPrimaryColor.withAlpha(64),
      child: StrutText(
        initials,
        style: textStyle,
      ),
    );
  }
}

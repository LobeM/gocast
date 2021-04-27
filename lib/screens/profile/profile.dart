import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/screens/profile/widgets/profile_info.dart';
import 'package:gocast/widgets/arrow_right_icon.dart';
import 'package:gocast/widgets/list_item.dart';
import 'package:gocast/widgets/list_title.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ProfileInfo(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: ListView(
                    children: [
                      ListItem(
                        title: L10n.of(context).profileTitleSubscriptions,
                        leading: const Icon(Icons.library_music_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: L10n.of(context).profileTitleDownloads,
                        leading: const Icon(Icons.download_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: L10n.of(context).profileTitleEdit,
                        leading: const Icon(Icons.person_outline),
                        trailing: ArrowRightIcon(),
                      ),
                      ListTitle(title: L10n.of(context).profileTitleConnect),
                      ListItem(
                        title: L10n.of(context).profileTitleShare,
                        leading: const Icon(Icons.share),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: L10n.of(context).profileTitleRate,
                        leading: const Icon(Icons.star_outline),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: L10n.of(context).profileTitleHelp,
                        leading: const Icon(Icons.help_outline_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListTitle(title: L10n.of(context).profileTitleMore),
                      ListItem(
                        title: L10n.of(context).profileTitleSettings,
                        leading: const Icon(Icons.settings_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: L10n.of(context).profileTitleAbout,
                        leading: const Icon(Icons.info_outline),
                        trailing: ArrowRightIcon(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

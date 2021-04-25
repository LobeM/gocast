import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/constants.dart';
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
                        title: 'My Subscriptions',
                        leading: const Icon(Icons.library_music_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: 'My Downloads',
                        leading: const Icon(Icons.download_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: 'Edit Profile',
                        leading: const Icon(Icons.person_outline),
                        trailing: ArrowRightIcon(),
                      ),
                      ListTitle(title: 'Connect'),
                      ListItem(
                        title: 'Share GoCast',
                        leading: const Icon(Icons.share),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: 'Rate Us',
                        leading: const Icon(Icons.star_outline),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: 'Help',
                        leading: const Icon(Icons.help_outline_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListTitle(title: 'More'),
                      ListItem(
                        title: 'Settings',
                        leading: const Icon(Icons.settings_outlined),
                        trailing: ArrowRightIcon(),
                      ),
                      ListItem(
                        title: 'About us',
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

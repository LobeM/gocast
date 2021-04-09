import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/auth/auth_bloc.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/data/models/bottom_bar_item_model.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/explore/explore.dart';
import 'package:gocast/screens/library/library.dart';
import 'package:gocast/screens/library/library_welcome.dart';
import 'package:gocast/screens/profile/profile.dart';
import 'package:gocast/screens/sign_in.dart';
import 'package:gocast/utils/bottom_bar_items.dart';
import 'package:gocast/utils/string.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Creates the bottom bar items.
  List<BottomNavigationBarItem> _bottomBarItems(BuildContext context) {
    getIt.get<BottomBarItems>().clear();
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'explore', icon: Icons.explore));
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'library', icon: Icons.headset));
    getIt
        .get<BottomBarItems>()
        .add(const BottomBarItemModel(id: 'profile', icon: Icons.person));

    final List<BottomNavigationBarItem> bottomBarItems =
        <BottomNavigationBarItem>[];

    for (final BottomBarItemModel item
        in getIt.get<BottomBarItems>().getItems()) {
      bottomBarItems.add(BottomNavigationBarItem(
        icon: Icon(item.icon),
        label: item.id.toTitleCases(),
      ));
    }

    return bottomBarItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return IndexedStack(
            index: _selectedIndex,
            children: [
              ExploreScreen(
                  key: getIt.get<AppGlobals>().globalKeyExploreScreen),
              // if (getIt.get<AppGlobals>().user != null)
              //   LibraryScreen()
              // else
              LibraryScreen(),
              if (getIt.get<AppGlobals>().user != null)
                ProfileScreen()
              else
                SignInScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        key: getIt.get<AppGlobals>().globalKeyBottomBar,
        items: _bottomBarItems(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

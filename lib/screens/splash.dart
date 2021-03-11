import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/application/application_bloc.dart';
import 'package:gocast/widgets/full_screen_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<ApplicationBloc>(context).add(SetupApplicationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FullScreenIndicator();
}

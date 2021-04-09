import 'package:flutter/material.dart';

class LibraryWelcomeScreen extends StatefulWidget {
  @override
  _LibraryWelcomeScreenState createState() => _LibraryWelcomeScreenState();
}

class _LibraryWelcomeScreenState extends State<LibraryWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Sign in to view library'),
    );
  }
}

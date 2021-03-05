import 'package:flutter/material.dart';

/// General purpose empty screen.
class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Implemented'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}

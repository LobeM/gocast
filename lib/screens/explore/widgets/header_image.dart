import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';

class HeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage(AssetsImages.background),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.grey[700], BlendMode.overlay)),
      ),
    );
  }
}

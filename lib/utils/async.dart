import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Various async functions.
class Async {
  /// Opens an URL in external browser.
  static Future<void> launchUrl(String url) async {
    /// May crash on emulator!
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  /// Creates a method that handles the asset path and receives a size (this can
  /// be either the width, height, or both, but using only one will preserve
  /// ratio).
  ///
  /// https://stackoverflow.com/a/56534916
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui
        .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  /// Loads the custom Google Map pin.
  // static Future<Uint8List> loadCustomMapPin({int width = 64}) async {
  //   return await getBytesFromAsset(AssetsImages.mapMarker, width);
  // }
}

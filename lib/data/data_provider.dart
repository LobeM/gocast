import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:gocast/data/models/data_response_model.dart';
import 'package:gocast/utils/console.dart';

/// Provides a generic mechanism for loading model data from JSON files
class DataProvider {
  const DataProvider();

  Future<DataResponseModel> get(String file) async {
    // Wait for some random time. Simulate net activity ;)
    await Future<int>.delayed(Duration(seconds: Random().nextInt(1)));

    String content = '';

    try {
      content = await rootBundle.loadString('assets/data/$file.json');
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
    }

    return DataResponseModel.fromJson(content.isNotEmpty
        ? jsonDecode(content) as Map<String, dynamic>
        : <String, dynamic>{});
  }
}

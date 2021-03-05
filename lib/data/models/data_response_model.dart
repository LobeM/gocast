import 'package:gocast/data/models/data_response_error_model.dart';

/// Data response model.
///
/// Regardless of the method by which the query and variables were sent, the
/// response in this example app is returned in the body of the request in JSON
/// format. A query might result in some data and some errors, and those are
/// returned in a JSON object of the form:
///
/// {
///   "data": { ... }
///   "errors": [ ... ]
/// }
///
/// If there were no errors returned, the "errors" field is not present on the
/// response.
class DataResponseModel {
  DataResponseModel(this.data, this.errors);

  factory DataResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> _errors =
        json['errors'] as List<dynamic> ?? <dynamic>[];

    return DataResponseModel(
      json['data'] as Map<String, dynamic> ?? <String, dynamic>{},
      _errors
          .map<DataResponseErrorModel>((dynamic json) =>
              DataResponseErrorModel.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }

  final Map<String, dynamic> data;
  final List<DataResponseErrorModel> errors;
}

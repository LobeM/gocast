class DataResponseErrorModel {
  DataResponseErrorModel(
    this.code,
    this.message,
  );

  factory DataResponseErrorModel.fromJson(Map<String, dynamic> json) {
    return DataResponseErrorModel(
      json['code'] as String ?? '',
      json['message'] as String ?? '',
    );
  }

  final String code;
  final String message;

  @override
  String toString() => 'DataResponseErrorModel<code: $code, message: $message>';
}

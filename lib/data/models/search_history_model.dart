class SearchHistoryModel {
  SearchHistoryModel({this.id, this.query});

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'] as int ?? 0,
      query: json['query'] as String ?? '',
    );
  }

  final int id;
  final String query;
}

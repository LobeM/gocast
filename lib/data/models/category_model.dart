class CategoryModel {
  CategoryModel({
    this.id,
    this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? '',
    );
  }

  final int id;
  final String title;
}

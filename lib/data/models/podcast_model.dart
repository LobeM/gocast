class PodcastModel {
  PodcastModel({
    this.id,
    this.title,
    this.author,
    this.image,
  });

  final int id;
  final String title;
  final String author;
  final String image;

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    final String _image = json['image'] as String ?? '';
    return PodcastModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      image: _image.isNotEmpty ? _image : '',
    );
  }
}

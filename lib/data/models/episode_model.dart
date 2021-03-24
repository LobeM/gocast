class EpisodeModel {
  EpisodeModel({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.uploadDate,
  });

  final int id;
  final String title;
  final String description;
  final int duration;
  final DateTime uploadDate;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        uploadDate: DateTime.tryParse(json['upload_date'] as String ?? '') ??
            DateTime.now());
  }
}

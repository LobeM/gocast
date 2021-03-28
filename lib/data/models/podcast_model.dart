import 'package:gocast/data/models/episode_model.dart';

class PodcastModel {
  PodcastModel({
    this.id,
    this.title,
    this.author,
    this.imageUrl,
    this.episodes,
  });

  final int id;
  final String title;
  final String author;
  final String imageUrl;
  final List<EpisodeModel> episodes;

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    final String _imageUrl = json['image_url'] as String ?? '';
    final List<dynamic> _episodes =
        json['episodes'] as List<dynamic> ?? <dynamic>[];
    return PodcastModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        imageUrl: _imageUrl.isNotEmpty ? _imageUrl : '',
        episodes: _episodes
            .map<EpisodeModel>((dynamic json) =>
                EpisodeModel.fromJson(json as Map<String, dynamic>))
            .toList());
  }
}

import 'package:gocast/data/models/podcast_model.dart';

class SearchSessionModel {
  SearchSessionModel({
    this.podcasts,
    this.q = '',
    this.isLoading = false,
  });

  SearchSessionModel rebuild({
    String q,
    bool isLoading,
    List<PodcastModel> podcasts,
  }) {
    return SearchSessionModel(
      podcasts: podcasts ?? this.podcasts,
      q: q ?? this.q,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final String q;
  final bool isLoading;
  final List<PodcastModel> podcasts;
}

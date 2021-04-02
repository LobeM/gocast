import 'package:gocast/data/models/podcast_model.dart';

class ExploreSessionModel {
  ExploreSessionModel({
    this.activeExploreTab = 0,
    this.currentPage = 1,
    this.topPodcasts,
    this.topEpisodes,
    this.isLoading = false,
  });

  ExploreSessionModel rebuild({
    int activeExploreTab,
    int currentPage,
    List<PodcastModel> topPodcasts,
    List<PodcastModel> topEpisodes,
    bool isLoading,
  }) {
    return ExploreSessionModel(
      activeExploreTab: activeExploreTab ?? this.activeExploreTab,
      currentPage: currentPage ?? this.currentPage,
      topPodcasts: topPodcasts ?? this.topPodcasts,
      topEpisodes: topEpisodes ?? this.topEpisodes,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final int activeExploreTab;
  final int currentPage;
  final List<PodcastModel> topPodcasts;
  final List<PodcastModel> topEpisodes;
  final bool isLoading;
}

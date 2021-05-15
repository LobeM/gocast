import 'package:gocast/data/data_provider.dart';
import 'package:gocast/data/models/category_model.dart';
import 'package:gocast/data/models/data_response_model.dart';
import 'package:gocast/data/models/podcast_model.dart';

class PodcastRepository {
  const PodcastRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<CategoryModel>> getCategories() async {
    final DataResponseModel rawData = await dataProvider.get('categories');

    final List<dynamic> _categories =
        rawData.data['categories'] as List<dynamic> ?? <dynamic>[];

    return _categories
        .map<CategoryModel>((dynamic json) =>
            CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<PodcastModel>> getTopPodcasts() async {
    final DataResponseModel rawData = await dataProvider.get('top_podcasts');

    final List<dynamic> _podcasts =
        rawData.data['top_podcasts'] as List<dynamic> ?? <dynamic>[];

    return _podcasts
        .map<PodcastModel>((dynamic json) => PodcastModel.fromJson(json))
        .toList();
  }

  Future<PodcastModel> getPodcast(int id) async {
    final DataResponseModel rawData = await dataProvider.get('podcast_$id');
    print('podcast: ${rawData.data}');
    return PodcastModel.fromJson(rawData.data);
  }

  Future<List<PodcastModel>> getTopEpisodes() async {
    final DataResponseModel rawData = await dataProvider.get('top_episodes');

    final List<dynamic> _podcasts =
        rawData.data['top_episodes'] as List<dynamic> ?? <dynamic>[];

    return _podcasts
        .map<PodcastModel>((dynamic json) => PodcastModel.fromJson(json))
        .toList();
  }

  Future<List<PodcastModel>> getDownloadEpisodes() async {
    final DataResponseModel rawData = await dataProvider.get('top_episodes');

    final List<dynamic> _podcasts =
        rawData.data['top_episodes'] as List<dynamic> ?? <dynamic>[];

    return _podcasts
        .map<PodcastModel>((dynamic json) => PodcastModel.fromJson(json))
        .toList();
  }

  Future<List<PodcastModel>> getSubscribedPodcasts() async {
    print("called subs");
    final DataResponseModel rawData = await dataProvider.get('top_podcasts');

    final List<dynamic> _podcasts =
        rawData.data['top_podcasts'] as List<dynamic> ?? <dynamic>[];

    return _podcasts
        .map<PodcastModel>((dynamic json) => PodcastModel.fromJson(json))
        .toList();
  }
}

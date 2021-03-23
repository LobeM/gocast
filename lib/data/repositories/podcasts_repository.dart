import 'package:gocast/data/data_provider.dart';
import 'package:gocast/data/models/data_response_model.dart';
import 'package:gocast/data/models/podcast_model.dart';

class PodcastRepository {
  const PodcastRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<PodcastModel>> getTopPodcasts() async {
    final DataResponseModel rawData = await dataProvider.get('top_podcasts');

    final List<dynamic> _podcasts =
        rawData.data['top_podcasts'] as List<dynamic> ?? <dynamic>[];

    return _podcasts
        .map<PodcastModel>((dynamic json) => PodcastModel.fromJson(json))
        .toList();
  }
}

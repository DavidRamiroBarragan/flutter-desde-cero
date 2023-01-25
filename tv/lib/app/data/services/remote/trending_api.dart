import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class TrendingApi {
  final Http _http;

  TrendingApi(this._http);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final result = await _http.request('/trending/all/${timeWindow.name}',
        onSuccess: (json) {
      final list = List<Json>.from(json['results']);
      return list
          .where(
            (element) => element['media_type'] != 'person',
          )
          .map(Media.fromJson)
          .toList();
    });

    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }
}

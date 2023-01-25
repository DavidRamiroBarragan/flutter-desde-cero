import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/media/media.dart';
import '../../domain/repositories/trending_repository.dart';
import '../services/remote/trending_api.dart';

class TrendingRepositoryImpl extends TrendingRepository {
  final TrendingApi _trendingApi;

  TrendingRepositoryImpl(this._trendingApi);

  @override
  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) {
    return _trendingApi.getMoviesAndSeries(timeWindow);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/utils/get-image-url.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({Key? key}) : super(key: key);

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late final Future<EitherListMedia> _future;

  @override
  void initState() {
    final TrendingRepository trendingRepository = context.read();
    super.initState();
    _future = trendingRepository.getMoviesAndSeries(TimeWindow.week);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<EitherListMedia>(
        future: _future,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.when(
            left: (failure) => Text(failure.toString()),
            right: (list) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final Media media = list[index];
                  return Image.network(
                    getImageUrl(media.posterPath),
                  );
                },
                itemCount: list.length,
              );
            },
          );
        },
      ),
    );
  }
}

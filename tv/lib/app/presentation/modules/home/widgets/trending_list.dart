import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/trending_repository.dart';
import 'trending_tile.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'TRENDING',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                child: FutureBuilder<EitherListMedia>(
                  future: _future,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return snapshot.data!.when(
                      left: (failure) => Text(failure.toString()),
                      right: (list) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final Media media = list[index];
                            return TrendingTile(
                              media: media,
                              width: width,
                            );
                          },
                          itemCount: list.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

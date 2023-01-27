import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../global/utils/get-image-url.dart';

class TrendingTile extends StatelessWidget {
  final Media media;
  final double width;

  const TrendingTile({
    Key? key,
    required this.media,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                getImageUrl(media.posterPath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Opacity(
                opacity: 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        media.voteAverage.toStringAsFixed(1),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Icon(
                        media.type == MediaType.movie ? Icons.movie : Icons.tv,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'avatar.dart';

import '../../models/publication.dart';

class PublicationItem extends StatelessWidget {
  final Publication publication;

  const PublicationItem({
    Key? key,
    required this.publication,
  }) : super(key: key);

  String _getEmojiPath(Reaction reaction) {
    switch (reaction) {
      case Reaction.like:
        return 'assets/emojis/like.svg';
      case Reaction.love:
        return 'assets/emojis/heart.svg';
      case Reaction.laughing:
        return 'assets/emojis/laughing.svg';
      case Reaction.sad:
        return 'assets/emojis/sad.svg';
      case Reaction.shocking:
        return 'assets/emojis/shocked.svg';
      case Reaction.angry:
        return 'assets/emojis/angry.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    const reactions = Reaction.values;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 6,
            color: Color(0xffEBEBEB),
          ),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Avatar(asset: publication.user.avatar, size: 38),
                const SizedBox(
                  width: 10,
                ),
                Text(publication.user.username),
                const Spacer(),
                Text(
                  timeago.format(publication.createAt),
                )
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: publication.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ).copyWith(
              top: 15,
            ),
            child: Text(
              publication.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
              bottom: 10,
            ),
            child: Row(
              children: [
                ...List.generate(
                  reactions.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          _getEmojiPath(
                            reactions[index],
                          ),
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Icon(
                          Icons.circle,
                          color: index == publication.reaction.index
                              ? Colors.redAccent
                              : Colors.transparent,
                          size: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text('${publication.commentsCount} Comments'),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('${publication.shareCount} Shares'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:clon_facebook/models/story.dart';
import 'package:flutter/material.dart';

import 'avatar.dart';

class StoryItem extends StatelessWidget {
  const StoryItem(
      {Key? key,
        required this.story,
        required this.isFirst})
      : super(key: key);

  final Story story;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 15,
        left: isFirst? 20 : 0,
      ),
      height: 160,
      width: 90,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(story.bg), fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Avatar(
                    size: 40,
                    asset: story.avatar,
                    border: 3,
                  ),
                )
              ],
            ),
          ),
          Text(
            story.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'quick_button.dart';
import '../../icons/custom_icons_icons.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: const [
            QuickButton(
              text: 'Gallery',
              iconData: CustomIcons.photos,
              color: Color(0xff92BE87),
            ),
            SizedBox(width: 15,),
            QuickButton(
              text: 'Tag Friends',
              iconData: CustomIcons.user_friends,
              color: Color(0xff2880D4),
            ),
            SizedBox(width: 15,),
            QuickButton(
              text: 'Live',
              iconData: CustomIcons.video_camera,
              color: Color(0xffFB7171),
            )
          ],
        ),
      ),
    );
  }
}

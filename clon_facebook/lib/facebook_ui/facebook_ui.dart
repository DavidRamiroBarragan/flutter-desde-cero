import 'widgets/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/circle_button.dart';
import 'widgets/what_is_on_your_mind.dart';

import '../icons/custom_icons_icons.dart';

class FacebookUI extends StatelessWidget {
  const FacebookUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SvgPicture.asset(
          'assets/logos/facebook.svg',
          color: Colors.blueAccent,
          width: 150,
        ),
        leadingWidth: 150,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        actions: const [
          CircleButton(
            iconData: CustomIcons.search,
            color: Color(0xffBFBFBF),
          ),
          SizedBox(
            width: 18,
          ),
          CircleButton(
            iconData: CustomIcons.bell,
            color: Color(0xffFE7574),
          ),
          SizedBox(
            width: 18,
          ),
          CircleButton(
            iconData: CustomIcons.user_friends,
            color: Color(0xff7BBAFF),
            showBadge: true,
          ),
          SizedBox(
            width: 18,
          ),
          CircleButton(
            iconData: CustomIcons.messenger,
            color: Color(0xff1C86E4),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ).copyWith(
          top: 15,
        ),
        children: const [
          WhatIsOnYourMind(),
          SizedBox(
            height: 25,
          ),
          QuickActions(),
        ],
      ),
    );
  }
}

import 'package:clon_facebook/facebook_ui/widgets/publication.dart';
import 'package:clon_facebook/facebook_ui/widgets/stories.dart';
import 'package:clon_facebook/models/publication.dart';
import 'package:faker/faker.dart';

import 'widgets/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/circle_button.dart';
import 'widgets/what_is_on_your_mind.dart';

import '../icons/custom_icons_icons.dart';

class FacebookUI extends StatefulWidget {
  const FacebookUI({Key? key}) : super(key: key);

  @override
  State<FacebookUI> createState() => _FacebookUIState();
}

class _FacebookUIState extends State<FacebookUI> {

  final faker = Faker();
  final List<Publication> publications = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 50; i++) {
      final publication = Publication(
        user: User(
          avatar: faker.image.image(),
          username: faker.person.name(),
        ),
        title: faker.lorem.sentence(),
        commentsCount: faker.randomGenerator.integer(100),
        reaction: Reaction.values[faker.randomGenerator.integer(
          Reaction.values.length - 1,
          min: 0,
        )],
        createAt: faker.date.dateTime(),
        imageUrl: faker.image.image(),
        shareCount: faker.randomGenerator.integer(100),
      );
      publications.add(publication);
    }
  }
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
        children: [
          const WhatIsOnYourMind(),
          const SizedBox(
            height: 25,
          ),
          const QuickActions(),
          const SizedBox(
            height: 25,
          ),
          const Stories(),
          const SizedBox(
            height: 25,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return PublicationItem(publication: publications[index]);
            },
            itemCount: publications.length,
          )
        ],
      ),
    );
  }
}

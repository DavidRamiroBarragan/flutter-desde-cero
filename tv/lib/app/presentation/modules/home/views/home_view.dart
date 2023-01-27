import 'package:flutter/material.dart';

import '../widgets/trending_list.dart';
import '../widgets/trending_performers.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(
              height: 10,
            ),
            TrendingList(),
            SizedBox(
              height: 20,
            ),
            TrendingPerformers(),
          ],
        ),
      ),
    );
  }
}

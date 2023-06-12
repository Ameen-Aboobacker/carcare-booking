import 'package:carcareuser/.core/constants.dart';
import 'package:flutter/material.dart';

import 'main_card.dart';
import 'main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({
    super.key,
    required this.title, required this.postersList,
  });
  final String title;
  final List<String> postersList;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MainTitle(
        title: title,
      ),
      kHeight,
      LimitedBox(
        maxHeight: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            postersList.length,
            (index) => MainCard(imageUrl: postersList[index]),
          ),
        ),
      ),
    ]);
  }
}

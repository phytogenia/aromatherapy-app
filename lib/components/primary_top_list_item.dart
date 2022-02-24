import 'package:aromatherapy/components/primary_top_item_card.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryTopListItems extends StatelessWidget {
  const PrimaryTopListItems({
    Key? key,
    required this.list,
    required this.imagePath,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final List<dynamic> list;
  final String imagePath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PrimaryTopItemCard(
            text: list[index],
            subText: '${list[index]} Scientific name',
            imagePath: imagePath,
            backgroundColor: backgroundColor,
          );
        });
  }
}

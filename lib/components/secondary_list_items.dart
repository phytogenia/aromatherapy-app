import 'package:aromatherapy/components/secondary_item_card.dart';
import 'package:flutter/material.dart';

import '../models/oil/oil.dart';
import '../utils/constants.dart';

class SecondaryListItems extends StatelessWidget {
  const SecondaryListItems({
    Key? key,
    required this.list,
    required this.imagePath,
    required this.oil,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final List<dynamic> list;
  final String imagePath;
  final Color backgroundColor;
  final Oil oil;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SecondaryItemCard(
            text: list[index],
            subText: '${list[index]} Scientific name',
            oil: oil,
            imagePath: imagePath,
            backgroundColor: kPrimaryColor);
      },
    );
  }
}

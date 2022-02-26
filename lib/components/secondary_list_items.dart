import 'package:aromatherapy/components/secondary_item_card.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SecondaryListItems extends StatelessWidget {
  const SecondaryListItems({
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
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SecondaryItemCard(
            text: list[index],
            subText: '${list[index]} Scientific name',
            imagePath: imagePath,
            backgroundColor: kPrimaryColor);
      },
    );
  }
}
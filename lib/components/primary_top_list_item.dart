import 'package:aromatherapy/components/primary_top_item_card.dart';
import 'package:flutter/material.dart';

import '../models/oil/oil.dart';
import '../utils/constants.dart';

class PrimaryTopListItems extends StatelessWidget {
  const PrimaryTopListItems({
    Key? key,
    required this.list,
    required this.iconData,
    required this.iconColor,
    required this.oil,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final List<dynamic> list;
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final Oil oil;

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
            iconData: iconData,
            iconColor: iconColor,
            oil: oil,
            backgroundColor: backgroundColor,
          );
        });
  }
}

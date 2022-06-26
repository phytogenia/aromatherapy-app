import 'package:aromatherapy/components/primary_list_properties.dart';
import 'package:aromatherapy/components/primary_top_item_card.dart';
import 'package:flutter/material.dart';

import '../models/oil/oil.dart';
import '../utils/constants.dart';

class PrimaryOilTitlesItems extends StatelessWidget {
  const PrimaryOilTitlesItems({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color

  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: color,
                fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            subtitle,
            style: TextStyle(
                fontSize: 15,
                color: color,
                fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

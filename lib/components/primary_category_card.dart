import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryCategoryCard extends StatelessWidget {
  const PrimaryCategoryCard(
      {Key? key,
      required this.text,
      this.backgroundColor = kPrimaryColor,
      required this.iconImagePath})
      : super(key: key);

  final Color backgroundColor;
  final String text;
  final String iconImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: backgroundColor),
          color: Colors.white),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconImagePath,
              height: 30,
              width: 30,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(color: backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

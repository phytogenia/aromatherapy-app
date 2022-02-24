import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryTopItemCard extends StatelessWidget {
  const PrimaryTopItemCard({
    Key? key,
    required this.text,
    required this.subText,
    required this.imagePath,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final String text;
  final String subText;
  final String imagePath;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      width: 130,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                // Empty Container to align the icon on the right with spacebetween
                Image.asset(imagePath)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              subText,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

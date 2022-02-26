import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

class SecondaryItemCard extends StatelessWidget {
  const SecondaryItemCard({
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(color: kSecondaryTextColor),
              color: kSecondaryBackgroundColor),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: kPrimaryTextColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  subText,
                  style: const TextStyle(color: kPrimaryTextColor),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(imagePath),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

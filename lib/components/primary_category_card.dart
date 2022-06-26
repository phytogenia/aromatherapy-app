import 'package:aromatherapy/screens/home/oils/oils_list_screen.dart';
import 'package:aromatherapy/screens/home/recipes/recipes_list_screen.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryCategoryCard extends StatelessWidget {
  const PrimaryCategoryCard(
      {Key? key,
      required this.text,
      this.backgroundColor = kPrimaryColor,
      required this.iconData,
      required this.iconColor})
      : super(key: key);

  final Color backgroundColor;
  final String text;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  text.contains("Oil") ? const HomeOil() : const HomeRecipes()),
        ); //TODO: refactore
      },
      child: Container(
        width: 130,
        height: 100,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: backgroundColor),
            color: kSecondaryBackgroundColor),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 30, color: iconColor),
              const SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(color: backgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

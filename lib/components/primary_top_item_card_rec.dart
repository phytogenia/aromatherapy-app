import 'package:aromatherapy/models/recipe/recipe.dart';
import 'package:aromatherapy/screens/home/oils/oil_details.dart';
import 'package:aromatherapy/screens/home/recipes/recipes_details.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/oil/oil.dart';

class PrimaryTopItemCardRecipe extends StatelessWidget {
  const PrimaryTopItemCardRecipe({
    Key? key,
    required this.text,
    required this.subText,
    required this.imagePath,
    required this.recipe,
    this.backgroundColor = kSecondaryColor,
  }) : super(key: key);

  final String text;
  final String subText;
  final String imagePath;
  final Color backgroundColor;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipesDetails(recipe: recipe,))); //TODO: refactore
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(9),
        width: 130,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
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
                  Image.asset(imagePath,color: whitecolor,)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: kSecondaryBackgroundColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  subText,
                  style: const TextStyle(color: kSecondaryBackgroundColor,fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:aromatherapy/screens/home/recipes/recipes_details.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/recipe/recipe.dart';
import '../screens/paywall_screen.dart';
import '../services/purchase_service.dart';

class SecondaryItemCardRecipes extends StatelessWidget {
  const SecondaryItemCardRecipes({
    Key? key,
    required this.text,
    required this.subText,
    required this.iconData,
    required this.iconColor,
    required this.recipe,
    this.backgroundColor = kSecondaryColor,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData iconData;
  final Color iconColor;
  final Recipe recipe;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool isUserProMember = await PurchaseService.isProMember();
        if (isUserProMember) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipesDetails(
                recipe: recipe,
              ),
            ),
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PayWallScreen(),
              ));
        }
      },
      child: Padding(
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
            child: Row(
              children: [
                const SizedBox(
                  width: 70,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subText,
                      style: const TextStyle(color: kPrimaryTextColor),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            bottom: 30,
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
                    Icon(
                      iconData,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

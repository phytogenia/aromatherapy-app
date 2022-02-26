import 'package:aromatherapy/screens/home/oils/oil_details.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OilDetails())); //TODO: refactore
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
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
                  Image.asset(imagePath)
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
                  style: const TextStyle(color: kSecondaryBackgroundColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

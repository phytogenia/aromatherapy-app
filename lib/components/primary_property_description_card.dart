import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryPropertyDescriptionCard extends StatelessWidget {
  PrimaryPropertyDescriptionCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: graycolorclear,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                description,
                style: const TextStyle(
                    color: kPrimaryTextColor, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 30,
        width: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8, left: 8),
              height: 15,
              width: 15,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kSecondaryBackgroundColor),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    color: kSecondaryBackgroundColor,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

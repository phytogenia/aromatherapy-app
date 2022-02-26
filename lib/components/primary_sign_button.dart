import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimarySignButton extends StatelessWidget {
  Function() onTap;
  String text;

  PrimarySignButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: kSecondaryTextColor,
                  offset: Offset(0, 2),
                  blurRadius: 6)
            ],
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Text(
          text,
          style: const TextStyle(
              color: kSecondaryBackgroundColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimarySocialMediaButton extends StatelessWidget {
  PrimarySocialMediaButton(
      {Key? key, required this.onTap, required this.imagePath})
      : super(key: key);

  Function() onTap;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.scaleDown,
          ),
          shape: BoxShape.circle,
          border:
              Border.all(color: kSecondaryTextColor.withOpacity(.6), width: 1),
        ),
      ),
    );
  }
}

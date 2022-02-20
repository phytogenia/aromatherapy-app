import 'package:flutter/material.dart';

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
              BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 6)
            ],
            color: Color(0xff61BB46),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

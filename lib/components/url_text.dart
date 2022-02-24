import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';

class UrlText extends StatelessWidget {
  final String text;
  final String url;
  final TextStyle? style;
  UrlText({required this.text, required this.url, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Text(
        text,
        style: style ??
            const TextStyle(
              fontWeight: FontWeight.w800,
              color: kPrimaryTextColor,
            ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}

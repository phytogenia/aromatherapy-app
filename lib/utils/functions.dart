import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Functions {
  static Widget buildImageAsset(String? imageAsset,
      {double height = 60, double width = 60}) {
    if (imageAsset == null) {
      return const SizedBox();
    }
    return Image.asset(
      imageAsset,
      height: height,
      width: width,
    );
  }

  static String capitalizeString(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
}

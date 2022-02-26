import 'package:aromatherapy/components/primary_property_item.dart';
import 'package:flutter/material.dart';

class PrimaryListProperties extends StatelessWidget {
  PrimaryListProperties({Key? key, required this.properties}) : super(key: key);

  List<String> properties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: properties.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return PrimaryPropertyItem(text: properties[index]);
      },
    );
  }
}

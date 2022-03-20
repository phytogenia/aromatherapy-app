import 'package:aromatherapy/components/primary_list_properties.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PrimaryOilDetailsItems extends StatelessWidget {
  const PrimaryOilDetailsItems({
    Key? key,
    required this.type,
    required this.list,
  }) : super(key: key);

  final String type;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            type,
            style: const TextStyle(
                fontSize: 15,
                color: kPrimaryTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: PrimaryListProperties(properties: list),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

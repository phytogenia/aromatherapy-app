import 'package:aromatherapy/components/primary_property_description_card.dart';
import 'package:aromatherapy/models/oil/oil_domain.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PrimaryPropertiesListItems extends StatelessWidget {
  const PrimaryPropertiesListItems({
    Key? key,
    required this.domain,
  }) : super(key: key);

  final OilDomain? domain;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: domain != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: domain!.toMap().entries.toList().length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var entryList = domain!.toMap().entries.toList();
                  return entryList[index].value != null
                      ? PrimaryPropertyDescriptionCard(
                          color: kPrimaryColor,
                          title: entryList[index].key,
                          description: entryList[index].value,
                        )
                      : const SizedBox(
                          height: 0,
                        );
                })
            : const SizedBox(
                height: 0,
              ));
  }
}

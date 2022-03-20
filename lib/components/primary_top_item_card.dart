import 'package:aromatherapy/screens/home/oils/oil_details.dart';
import 'package:aromatherapy/screens/paywall_screen.dart';
import 'package:aromatherapy/services/purchase_service.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/entitlement.dart';
import '../models/oil/oil.dart';
import '../services/revenuecat_provider.dart';

class PrimaryTopItemCard extends StatelessWidget {
  const PrimaryTopItemCard({
    Key? key,
    required this.text,
    required this.subText,
    required this.imagePath,
    required this.oil,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final String text;
  final String subText;
  final String imagePath;
  final Color backgroundColor;
  final Oil oil;

  @override
  Widget build(BuildContext context) {
    final entitlement = context.read<RevenueCatProvider>();

    return GestureDetector(
      onTap: () async {
        final offering = await PurchaseService.fetchOffers();
        if (offering.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            content: Text('No Plans Found'),
          )));
        } else {
          final packages = offering
              .map((offer) => offer.availablePackages)
              .expand((pair) => pair)
              .toList();

          if (entitlement == Entitlement.allContent) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OilDetails(
                  oil: oil,
                ),
              ),
            ); //TODO: refactore
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PayWallScreen(),
              ),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(9),
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
                  Image.asset(
                    imagePath,
                    color: whitecolor,
                  )
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
                  style: const TextStyle(
                      color: kSecondaryBackgroundColor, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

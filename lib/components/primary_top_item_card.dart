import 'package:aromatherapy/screens/home/oils/oil_details.dart';
import 'package:aromatherapy/screens/paywall_screen.dart';
import 'package:aromatherapy/services/purchase_service.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/oil/oil.dart';

class PrimaryTopItemCard extends StatelessWidget {
  const PrimaryTopItemCard({
    Key? key,
    required this.text,
    required this.subText,
    required this.iconData,
    required this.iconColor,
    required this.oil,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final Oil oil;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool isUserProMember = await PurchaseService.isProMember();
        if (isUserProMember) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OilDetails(
                oil: oil,
              ),
            ),
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PayWallScreen(),
              ));
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
                  Icon(iconData, size: 30, color: iconColor),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: kSecondaryBackgroundColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  subText,
                  overflow: TextOverflow.ellipsis,
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

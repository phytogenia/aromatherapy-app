import 'package:aromatherapy/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

import '../services/purchase_service.dart';
import '../utils/constants.dart';

class PayWallScreen extends StatefulWidget {
  final String title;
  final String description;
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const PayWallScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.packages,
      required this.onClickedPackage})
      : super(key: key);

  @override
  _PayWallScreenState createState() => _PayWallScreenState();
}

class _PayWallScreenState extends State<PayWallScreen> {
  double redm = 0;
  double redy = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              buildPackages(),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Includes 7-day trial, you can cancel at any time in this periode.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: kSecondaryTextColor,
                            offset: Offset(0, 2),
                            blurRadius: 6)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'By continuing, you agree to Aromatherapy’s Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPackages() {
    return SizedBox(
      height: 180,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: widget.packages.length,
          itemBuilder: (context, index) {
            final package = widget.packages[index];
            return buildPackage(context, package);
          },
        ),
      ),
    );
  }

  Widget buildPackage(BuildContext context, Package package) {
    final product = package.product;
    product.title.contains("Month")
        ? redm = product.price
        : redy = product.price / 12;

    return GestureDetector(
      onTap: () => widget.onClickedPackage(package),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 250,
            width: 120,
            margin: const EdgeInsets.only(right: 10, left: 10),
            decoration: const BoxDecoration(
                color: kSecondaryBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: kSecondaryTextColor,
                      offset: Offset(2, 2),
                      blurRadius: 16)
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    product.priceString,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  product.title.contains("Month")
                      ? Text(
                          product.priceString + " / mo",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        )
                      : Text(
                          (product.price / 12).toString() + " / mo",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        )
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 90,
              width: 120,
              margin: const EdgeInsets.only(right: 10, left: 10),
              decoration: const BoxDecoration(
                color: graycolorclear,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: product.title.contains("Month")
                    ? const Text("1\nMONTH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                    : const Text("1\nYEAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
          ),
          !product.title.contains("Month")
              ? Positioned(
                  top: -15,
                  child: Container(
                    margin: EdgeInsets.only(left: 40),
                    decoration: const BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        child: Text(
                            "SAVE " +
                                ((redm - redy) * 100 / redm)
                                    .round()
                                    .toString() +
                                "%",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white))),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

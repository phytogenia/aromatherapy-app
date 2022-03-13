import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

import '../utils/constants.dart';

class PayWallWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const PayWallWidget(
      {Key? key, required this.title, required this.description, required this.packages, required this.onClickedPackage})
      : super(key: key);

  @override
  _PayWallWidgetState createState() => _PayWallWidgetState();
}

class _PayWallWidgetState extends State<PayWallWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: kSecondaryBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: kSecondaryTextColor,
                  offset: Offset(2, 2),
                  blurRadius: 16)
            ]),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            Text(widget.description,textAlign: TextAlign.center,style: const TextStyle(fontSize: 15),),
            const SizedBox(height: 16,),
            buildPackages(),
          ],
        ),
      ),
    );
  }
  Widget buildPackages(){
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.packages.length,
      itemBuilder: (context,index){
        final package = widget.packages[index];
        return buildPackage(context,package);
      },
    );
  }
  Widget buildPackage(BuildContext context, Package package){
    final product = package.product;

    return Card(
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onTap: () => widget.onClickedPackage(package),
        ),

    );
  }
}
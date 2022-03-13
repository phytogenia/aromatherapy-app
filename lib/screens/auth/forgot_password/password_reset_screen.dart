import 'package:aromatherapy/components/main_card_widget.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import '../../revenuecat.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Maincardwidget(columnWidget: _passwordreset(context),),
    );
  }
}

Widget _passwordreset(BuildContext context) {
  return Column(children: [
    const Align(
      alignment: Alignment.center,
      child: Text(
        'Reset Password',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
    const SizedBox(height: 60),
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: kPrimaryColor,
            hintText: 'New password',
            hintStyle:
            TextStyle(fontSize: 15, color: Colors.grey.withOpacity(.7))),
      ),
    ),
    const SizedBox(height: 10),
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: kPrimaryColor,
            hintText: 'Confirm new password',
            hintStyle:
            TextStyle(fontSize: 15, color: Colors.grey.withOpacity(.7))),
      ),
    ),
    const SizedBox(height: 100),
    GestureDetector(
      onTap: () {
        fetchoffers(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: graycolor, offset: Offset(0, 2), blurRadius: 6)
            ],
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: const Text(
          'Submit',
          style: TextStyle(color: whitecolor, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ]);
}

Future fetchoffers(BuildContext context) async {
  final offering = await PurchaseApi.fetchOffers();
  if (offering.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
        (const SnackBar(content: Text('No Plans Found'),

        )));
  } else {
  final packages = offering
      .map((offer) => offer.availablePackages)
      .expand((pair) => pair)
      .toList();

  showModalBottomSheet(context: context,
      builder: (context) => PayWallWidget(title: 'Upgrade Your Plan', description: 'Upgrade to a new plan', packages: packages,
      onClickedPackage: (package) async {
        await PurchaseApi.PurchasePackage(package);
        Navigator.pop(context);
      }));}
}

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
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            Text(widget.description,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
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
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(
            product.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () => widget.onClickedPackage(package),
        ),
      ),
    );
  }
}


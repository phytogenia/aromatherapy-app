import 'package:aromatherapy/components/main_card_widget.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

import 'confirm_phone_number_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Maincardwidget(columnWidget: _forgotpassword(context),), // type 0 = forgot password
    );
  }
}

Widget _forgotpassword(BuildContext context) {
  return Column(children: [
    const Align(
      alignment: Alignment.center,
      child: Text(
        'Forgot your password ?',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ),
    const SizedBox(height: 10),
    const Center(
      child: Text(
        'Don’t worry! It happens. Please enter the address associated with your account.',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
    ),
    const SizedBox(height: 60),
    Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: kPrimaryColor,
            hintText: 'Enter you Email',
            hintStyle:
            TextStyle(fontSize: 15, color: Colors.grey.withOpacity(.7))),
      ),
    ),
    const SizedBox(height: 100),
    GestureDetector(
      onTap: () {
        // Sigup method
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ConfirmPhoneNumberScreen()));
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


import 'package:aromatherapy/components/main_card_widget.dart';
import 'package:aromatherapy/screens/auth/forgot_password/password_reset_screen.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:flutter/material.dart';

class ConfirmPhoneNumberScreen extends StatefulWidget {
  const ConfirmPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _ConfirmPhoneNumberScreenState createState() =>
      _ConfirmPhoneNumberScreenState();
}

class _ConfirmPhoneNumberScreenState extends State<ConfirmPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Maincardwidget(columnWidget: _phone_confirmation(context),), // type 0 = forgot password
    );
  }
}
Widget _phone_confirmation(BuildContext context) {
  return Column(children: [
    const Align(
      alignment: Alignment.center,
      child: Text(
        'Enter your confirmation \n number',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
    const SizedBox(height: 10),
    const Center(
      child: Text(
        'An 4 digit code has been sent to your email adress',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
    ),
    const SizedBox(height: 60),
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
                focusColor: kPrimaryColor, counterText: ''),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(.2),
              border: Border.all(color: Colors.grey.withOpacity(.6), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
        ),
        const SizedBox(width: 15),
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLength: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                focusColor: kPrimaryColor, counterText: ''),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(.2),
              border: Border.all(color: Colors.grey.withOpacity(.6), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
        ),
        const SizedBox(width: 15),
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
                focusColor: kPrimaryColor, counterText: ''),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(.2),
              border: Border.all(color: Colors.grey.withOpacity(.6), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
        ),
        const SizedBox(width: 15),
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
                focusColor: kPrimaryColor, counterText: ''),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(.2),
              border: Border.all(color: Colors.grey.withOpacity(.6), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
        ),
      ],
    ),
    const SizedBox(height: 100),
    GestureDetector(
      onTap: () {
        // Sigup method
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PasswordResetScreen()));
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

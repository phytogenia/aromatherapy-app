import 'package:aromatherapy/components/main_card_widget.dart';
import 'package:aromatherapy/screens/auth/forgot_password/password_reset_screen.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'confirm_phone_number_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Maincardwidget(
        columnWidget: _forgotpassword(context, emailController),
      ), // type 0 = forgot password
    );
  }
}

Widget _forgotpassword(
    BuildContext context, TextEditingController emailController) {
  Future verifyEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text(
        "Password Reset Email Sent",
      ))));

      /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PasswordResetScreen()));*/

      Navigator.of(context).popUntil((rout) => rout.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      ScaffoldMessenger.of(context)
          .showSnackBar((SnackBar(content: Text(e.message.toString()))));
      Navigator.of(context).pop();
    }
  }

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
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
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
        verifyEmail();
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

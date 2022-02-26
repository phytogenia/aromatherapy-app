import 'package:aromatherapy/screens/auth/forgot_password/password_reset_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

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
      backgroundColor: kSecondaryBackgroundColor,
      body: SafeArea(
        bottom: false,
        top: false,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 130.0)),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              kPrimaryColor.withOpacity(.8), BlendMode.srcOver),
                          image: const AssetImage('assets/images/pictop.jpg'),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Image.asset('assets/images/intersect.png'),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset('assets/images/picbottom.png')),
                Positioned(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: const BoxDecoration(
                          color: kSecondaryBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: kSecondaryBackgroundColor,
                                offset: Offset(2, 2),
                                blurRadius: 16)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Image.asset('assets/images/logo2.png'),
                              const SizedBox(height: 40),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Enter your confirmation \n number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Center(
                                child: Text(
                                  'An 4 digit code has been sent to your email adress',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                              const SizedBox(height: 60),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.all(8),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      decoration: const InputDecoration(
                                          focusColor: kPrimaryColor,
                                          counterText: ''),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color:
                                            kSecondaryTextColor.withOpacity(.2),
                                        border: Border.all(
                                            color: kSecondaryTextColor
                                                .withOpacity(.6),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.all(8),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLength: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          focusColor: kPrimaryColor,
                                          counterText: ''),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color:
                                            kSecondaryTextColor.withOpacity(.2),
                                        border: Border.all(
                                            color: kSecondaryTextColor
                                                .withOpacity(.6),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.all(8),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      decoration: const InputDecoration(
                                          focusColor: kPrimaryColor,
                                          counterText: ''),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color:
                                            kSecondaryTextColor.withOpacity(.2),
                                        border: Border.all(
                                            color: kSecondaryTextColor
                                                .withOpacity(.6),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.all(8),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      decoration: const InputDecoration(
                                          focusColor: kPrimaryColor,
                                          counterText: ''),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color:
                                            kSecondaryTextColor.withOpacity(.2),
                                        border: Border.all(
                                            color: kSecondaryTextColor
                                                .withOpacity(.6),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 100),
                              GestureDetector(
                                onTap: () {
                                  // Sigup method
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              PasswordResetScreen()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: kSecondaryTextColor,
                                            offset: Offset(0, 2),
                                            blurRadius: 6)
                                      ],
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: kSecondaryBackgroundColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

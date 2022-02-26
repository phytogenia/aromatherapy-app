import 'package:aromatherapy/screens/auth/forgot_password/confirm_phone_number_screen.dart';
import 'package:aromatherapy/screens/auth/forgot_password/password_reset_screen.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Maincardwidget extends StatelessWidget {

  const Maincardwidget({
    Key? key,
     required this.columnWidget,
  }) : super(key: key);

  final Widget columnWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: SingleChildScrollView(
        child: SizedBox(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
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
                            columnWidget
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}


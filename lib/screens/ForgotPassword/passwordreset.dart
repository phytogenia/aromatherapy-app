import 'package:aromatherapy/screens/OilDetails/oildetails.dart';
import 'package:flutter/material.dart';

import 'ConfirmPhoneNumber.dart';
class passwordreset extends StatefulWidget {
  const passwordreset({Key? key}) : super(key: key);

  @override
  _passwordresetState createState() => _passwordresetState();
}

class _passwordresetState extends State<passwordreset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
                              Color(0xff61BB46).withOpacity(.8),
                              BlendMode.srcOver),
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
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),


                                ),
                              ),

                              const SizedBox(height: 60),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.green,
                                      hintText: 'New password',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey
                                              .withOpacity(.7))),
                                ),
                              ),
                              const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.green,
                                      hintText: 'Confirm new password',
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey
                                              .withOpacity(.7))),
                                ),
                              ),

                              const SizedBox(height: 100),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>oildetails()));
                                },

                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 2),
                                            blurRadius: 6)
                                      ],
                                      color: Color(0xff61BB46),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
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

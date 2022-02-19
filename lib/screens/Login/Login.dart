import 'package:aromatherapy/screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:aromatherapy/screens/ForgotPassword/ForgotPassword.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  int SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        top: false,
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
                            Image.asset('assets/images/logo2.png'),
                            const SizedBox(height: 8),
                            DefaultTabController(
                                initialIndex: SelectedIndex,
                                length: 2,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.4),
                                          width: 1)),
                                  child: TabBar(
                                    onTap: (int index) {
                                      setState(() {
                                        isObscure = true;
                                        SelectedIndex = index;
                                      });
                                    },
                                    //indicatorColor: Color(0xff61BB46),
                                    tabs: const [
                                      Tab(
                                        text: "Sing in",
                                      ),
                                      Tab(
                                        text: "Sign up",
                                      ),
                                    ],
                                    unselectedLabelColor:
                                        const Color(0xff61BB46),
                                    labelColor: Colors.white,
                                    indicator: RectangularIndicator(
                                      color: Color(0xff61BB46),
                                      bottomLeftRadius: 100,
                                      bottomRightRadius: 100,
                                      topLeftRadius: 100,
                                      topRightRadius: 100,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 30),
                            SelectedIndex == 0
                                ? Form(
                                    child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Enter you Email',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(.7))),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          obscureText: isObscure,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isObscure =
                                                        !isObscure; // show and hide password
                                                  });
                                                },
                                                child: isObscure
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                              ),
                                              hintText: 'Enter you password',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(.7))),
                                        ),
                                      ),
                                    ],
                                  ))
                                : Form(
                                    child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Enter you Email',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(.7))),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          obscureText: isObscure,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isObscure =
                                                        !isObscure; // show and hide password
                                                  });
                                                },
                                                child: isObscure
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                              ),
                                              hintText: 'Enter you password',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(.7))),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          obscureText: isObscure,
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isObscure =
                                                        !isObscure; // show and hide password
                                                  });
                                                },
                                                child: isObscure
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off),
                                              ),
                                              hintText: 'Confirm you password',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                                      .withOpacity(.7))),
                                        ),
                                      ),
                                    ],
                                  )),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => FPassword()));},
                                child: const Text(
                                  'Forgot your password ?',
                                  style: TextStyle(
                                      color: Color(0xff61BB46),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                if (SelectedIndex == 0) {
                                  // Login method
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                } else {
                                  // Sigup method
                                  //Navigator.push(context, new MaterialPageRoute(builder: (context)=>Home()));
                                }
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
                                child: Text(
                                  SelectedIndex == 0 ? 'Sign in' : 'Sign up',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Expanded(
                                    child: Divider(
                                  indent: 70,
                                )),
                                SizedBox(width: 5),
                                Text(
                                  'OR',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Divider(
                                  endIndent: 70,
                                ))
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //facebook login method
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/facebook.png'),
                                          fit: BoxFit.scaleDown),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.6),
                                          width: 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    //apple login method
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/apple.png'),
                                          fit: BoxFit.scaleDown),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.6),
                                          width: 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    //google login method
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/google.png'),
                                          fit: BoxFit.scaleDown),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(.6),
                                          width: 1),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'By signing up, you agree to Aromatherapy\'s Terms of Service and Privacy Policy',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
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

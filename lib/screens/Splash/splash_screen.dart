import 'dart:async';
import 'package:aromatherapy/screens/Login/Login.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // No action bar will build
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF0ABB48),
          Color(0xFF009839),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(child: Image.asset('assets/images/logo.png', scale: 3)),
      ),
    );
  }
}

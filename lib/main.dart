import 'package:aromatherapy_vtest_app/routes.dart';
import 'package:aromatherapy_vtest_app/screens/Splash/splash_screen.dart';
import 'package:aromatherapy_vtest_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

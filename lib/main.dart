import 'package:aromatherapy/screens/landing_screen.dart';
import 'package:aromatherapy/services/revenuecat.dart';
import 'package:aromatherapy/services/auth_service.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:aromatherapy/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PurchaseApi.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => FirebaseAuthService(),
      child: MaterialApp(
        title: 'Aromatherapy App',
        home: const IntroScreen() ,
        theme: theme(),
      ),
    );
  }
}
class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  List<PageViewModel> getPages(){
    return [
      PageViewModel(
        title: "Title of first page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(child: Image.asset("assets/images/greenoil.png", height: 175.0)),
        decoration: const PageDecoration(
          pageColor: Colors.transparent,
        ),
      ),
      PageViewModel(
        title: "Title of first page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(child: Image.asset("assets/images/recipe.png", height: 175.0)),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold),
          bodyTextStyle: TextStyle(color: Colors.black,fontSize: 15),
          pageColor: Colors.transparent,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showNextButton: false,
      pages: getPages(),
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const LandingScreen(),
          ),
        );
      },
      showBackButton: false,
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600,color: kPrimaryColor)),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: kPrimaryColor)),
    );
  }
}

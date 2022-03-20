import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/oils/oils_list_screen.dart';
import '../screens/home/recipes/recipes_list_screen.dart';
import '../utils/constants.dart';

class HomeRecipes extends StatefulWidget {
  const HomeRecipes({Key? key}) : super(key: key);

  @override
  _HomeRecipesState createState() => _HomeRecipesState();
}

class _HomeRecipesState extends State<HomeRecipes> {
  final _Screens = [
    const OilListScreen(),
    const RecipesListScreen(),
    const HomeScreen(),

  ];
  int SelectedIndex = 2; //TODO :: enumeration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            SelectedIndex = 2;
          });
        },
        backgroundColor: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset('assets/images/home.png',
              color: kSecondaryBackgroundColor),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        onTap: (int index) {
          setState(() {
            SelectedIndex = index;
          });
        },
        icons: const [
          Icons.water_drop,
          Icons.soup_kitchen,
        ],
        activeIndex: SelectedIndex,
        rightCornerRadius: 0,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
      ),
      body: _Screens[SelectedIndex],
    );
  }
}
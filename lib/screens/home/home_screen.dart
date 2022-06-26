import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_future_builder.dart';
import 'package:aromatherapy/screens/home/recipes/recipes_list_screen.dart';
import 'package:aromatherapy/screens/home/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import '../../components/primary_category_card.dart';
import '../../utils/constants.dart';
import 'oils/oils_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _Screens = [
    const OilListScreen(),
    const RecipesListScreen(),
    const HomeScreen(),
  ];
  int SelectedIndex = 2; //TODO :: enumeration

  void setSelectedIndex(int index) {
    setState(() {
      SelectedIndex = index;
    });
  }

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
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Icon(Icons.home_filled, color: kSecondaryBackgroundColor),
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
        inactiveColor: kSecondaryTextColor,
        activeIndex: SelectedIndex,
        rightCornerRadius: 0,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
      ),
      body: _Screens[SelectedIndex],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categories = [];
  List oils = [];
  List recipes = [];

  CollectionReference oilss = FirebaseFirestore.instance.collection('oils');
  CollectionReference rcp = FirebaseFirestore.instance.collection('recipes');
  List<DocumentSnapshot> data = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Find your favorite oil'),
                                Text(
                                  'Essential Oil',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryColor),
                                child: const Center(
                                  child: Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.white,
                                  ) /*Text(
                                    'Y',
                                    style: TextStyle(
                                        color: kSecondaryBackgroundColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )*/
                                  ,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Categories',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            PrimaryCategoryCard(
                              text: 'Oil',
                              backgroundColor: kPrimaryColor,
                              iconColor: kPrimaryColor,
                              iconData: Icons.water_drop,
                            ),
                            PrimaryCategoryCard(
                              text: 'Recipe',
                              backgroundColor: kSecondaryColor,
                              iconColor: kSecondaryColor,
                              iconData: Icons.soup_kitchen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: Text(
                      'Popular Essential oils',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilderHome(
                    future: oilss,
                    type: 1,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: Text(
                      'Popular Essential recipes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilderHome(
                    future: rcp,
                    type: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

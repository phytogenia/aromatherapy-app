import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_top_item_card_rec.dart';
import 'package:aromatherapy/screens/home/recipes/recipes_list_screen.dart';
import 'package:aromatherapy/screens/home/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import '../paywall_screen.dart';
import '../../components/primary_category_card.dart';
import '../../components/primary_top_item_card.dart';
import '../../models/oil/oil.dart';
import '../../models/recipe/recipe.dart';
import '../../services/purchase_service.dart';
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
                                  child: Icon(Icons.account_circle_rounded,color: Colors.white,)/*Text(
                                    'Y',
                                    style: TextStyle(
                                        color: kSecondaryBackgroundColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )*/,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: kSecondaryBackgroundColor,
                          ),
                          height: 40,
                          child: Center(
                            child: TextFormField(
                              onTap: () {
                                final _HomeState? state = context
                                    .findAncestorStateOfType<_HomeState>();
                                state?.setSelectedIndex(0);
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: kSecondaryTextColor,
                                ),
                                hintText: 'Find your Essential oil',
                                hintStyle: TextStyle(fontSize: 12),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: kSecondaryTextColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: kPrimaryColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
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
                              iconImagePath: 'assets/images/greenoil.png',
                            ),
                            PrimaryCategoryCard(
                              text: 'Recipe',
                              backgroundColor: kSecondaryColor,
                              iconImagePath: 'assets/images/recipe.png',
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
                  SizedBox(
                    height: 120,
                    child: FutureBuilder<QuerySnapshot>(
                        future: oilss.get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            data = snapshot.data!.docs;

                            return ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                itemCount: data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Oil oil = Oil.fromMap(
                                      Map<String, dynamic>.from(
                                          data[index].data() as Map),
                                      data[index].id);
                                  return PrimaryTopItemCard(
                                    text: oil.name,
                                    subText: oil.sciName.toString(),
                                    imagePath: 'assets/images/whiteoil.png',
                                    oil: oil,
                                    backgroundColor: kPrimaryColor,
                                  );
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          );
                        }),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                    child: Text(
                      'Popular Essential recipes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      height: 120,
                      child: FutureBuilder<QuerySnapshot>(
                          future: rcp.get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<DocumentSnapshot> data2 =
                                  snapshot.data!.docs;

                              return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  itemCount: data2.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Recipe recipe = Recipe.fromMap(
                                        Map<String, dynamic>.from(
                                            data2[index].data() as Map),
                                        data2[index].id);
                                    return PrimaryTopItemCardRecipe(
                                      text: recipe.name,
                                      subText: recipe.reference.toString(),
                                      imagePath: 'assets/images/whiteoil.png',
                                      recipe: recipe,
                                      backgroundColor: kSecondaryColor,
                                    );
                                  });
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

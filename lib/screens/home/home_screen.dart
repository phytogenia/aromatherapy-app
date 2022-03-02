import 'dart:math';

import 'package:aromatherapy/screens/home/recipes/recipes_list_screen.dart';
import 'package:aromatherapy/screens/home/settings/settings_screen.dart';
import 'package:aromatherapy/services/auth_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/primary_category_card.dart';
import '../../components/primary_top_item_card.dart';
import '../../components/primary_top_list_item.dart';
import '../../models/oil/oil.dart';
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
    const HomeScreen(),
    const RecipesListScreen()
  ];
  int SelectedIndex = 1; //TODO :: enumeration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (int index) {
          setState(() {
            SelectedIndex = index;
          });
        },
        color: kSecondaryBackgroundColor,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: kPrimaryColor,
        index: SelectedIndex,
        items: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/whiteoil.png',
              color: SelectedIndex == 0
                  ? kSecondaryBackgroundColor
                  : kSecondaryTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/home.png',
              color: SelectedIndex == 1
                  ? kSecondaryBackgroundColor
                  : kSecondaryTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/recipe.png',
              color: SelectedIndex == 2
                  ? kSecondaryBackgroundColor
                  : kSecondaryTextColor,
            ),
          ),
        ],
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
  int SelectedIndex = 1; //TODO :: enumeration

  List categories = [];
  List oils = [];
  List recipes = [];

  CollectionReference oilss = FirebaseFirestore.instance.collection('oils');
  List<DocumentSnapshot> data = [];
  // This list holds the data for the list view
  List<DocumentSnapshot> _foundUsers = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      categories.addAll(["Category One", "Category Two"]);
      oils.addAll(['Oil 1', 'Oil 2', 'Oil 3', 'Oil 4', 'Oil 5']);
      recipes
          .addAll(['Recipe 1', 'Recipe 3', 'Recipe 3', 'Recipe 5', 'Recipe 5']);
    });
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<DocumentSnapshot> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = data;
    } else {
      results = data
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: oils.isEmpty || recipes.isEmpty || categories.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            )
          : SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        child: Text(
                                          'Y',
                                          style: TextStyle(
                                              color: kSecondaryBackgroundColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: kSecondaryBackgroundColor,
                                ),
                                height: 40,
                                child: Center(
                                  child: TextFormField(
                                    onTap: () {
                                      setState(() {
                                        SelectedIndex = 0;
                                      });
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
                                              width: 1,
                                              color: kSecondaryTextColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: kPrimaryColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Text(
                            'Popular Essential oils',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: FutureBuilder<QuerySnapshot>(
                              future: oilss.get(),
                            builder: (context,snapshot) {

                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                data = snapshot.data!.docs;
                                
                              return ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      itemCount: data.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                       Oil oil =Oil.fromMap(Map<String, dynamic>.from(data[index].data() as Map), snapshot.data?.docs[index].reference.id as String);
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

                            }
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Text(
                            'Popular Essential recipes',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: recipes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(9),
                                  width: 130,
                                  decoration: const BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(15))),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            // Empty Container to align the icon on the right with spacebetween
                                            Image.asset('assets/images/recipe.png',color: whitecolor,)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "text",
                                          style: TextStyle(
                                              color: kSecondaryBackgroundColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        const Flexible(
                                          child: Text(
                                            "subText",
                                            style: TextStyle(color: kSecondaryBackgroundColor,fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }) /*PrimaryTopListItems(
                            list: recipes,
                            backgroundColor: kSecondaryColor,
                            imagePath: 'assets/images/recipe.png',
                          ),*/
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

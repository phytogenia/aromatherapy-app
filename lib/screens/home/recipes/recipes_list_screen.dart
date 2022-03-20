import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_future_builder.dart';
import 'package:aromatherapy/components/primary_listview_builder.dart';
import 'package:aromatherapy/components/primary_top_item_card_rec.dart';
import 'package:aromatherapy/components/secondary_future_builder.dart';
import 'package:aromatherapy/components/secondary_item_cardRecipes.dart';
import 'package:aromatherapy/models/recipe/recipe.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../oils/oils_list_screen.dart';

class HomeRecipes extends StatefulWidget {
  const HomeRecipes({Key? key}) : super(key: key);

  @override
  _HomeRecipesState createState() => _HomeRecipesState();
}

class _HomeRecipesState extends State<HomeRecipes> {
  final _Screens = [
    const OilListScreen(),
    const HomeScreen(),
    const RecipesListScreen()
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

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({Key? key}) : super(key: key);

  @override
  _RecipesListScreenState createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  List oils = [];
  CollectionReference oilss = FirebaseFirestore.instance.collection('recipes');
  List<DocumentSnapshot> data = [];

  // This list holds the data for the list view
  late final _PrimaryListOilsState? state;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {});
  }

  // This function is called whenever the text field changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true, // this is all you need
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
              child: Text(
            "Essential recipes",
            style: TextStyle(
                color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 90),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.fill)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                      child: Text(
                        'Popular Essential recipes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilderHome(future: oilss, type: 2),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Find your favorite'),
                              Text(
                                'Essential Recipes',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          PrimaryListOils(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget BuildOils(BuildContext context, String oilname) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      width: 130,
      decoration: const BoxDecoration(
          color: kSecondaryColor,
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
                Image.asset('assets/images/recipe.png')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              oilname,
              style: const TextStyle(
                  color: kSecondaryBackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const Text(
              'Scientific name',
              style: TextStyle(color: kSecondaryBackgroundColor),
            )
          ],
        ),
      ),
    );
  }
}

class PrimaryListOils extends StatefulWidget {
  const PrimaryListOils({Key? key}) : super(key: key);

  @override
  _PrimaryListOilsState createState() => _PrimaryListOilsState();
}

class _PrimaryListOilsState extends State<PrimaryListOils> {
  List<DocumentSnapshot> data = [];
  List<DocumentSnapshot> _foundoils = [];
  CollectionReference oilss = FirebaseFirestore.instance.collection('recipes');

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

    setState(() {
      _foundoils = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: kSecondaryBackgroundColor,
          ),
          height: 40,
          child: Center(
            child: TextFormField(
              onChanged: (value) async {
                _runFilter(value);
                // cartKey.currentState?._runFilter(value);
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: kSecondaryTextColor,
                ),
                hintText: 'Quick search for recipes ...',
                hintStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: kSecondaryTextColor),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: kSecondaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: _foundoils.isNotEmpty
              ? ListBuilder(list: _foundoils, type: 2)
              : FutureBuilderSecond(future: oilss, type: 2),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

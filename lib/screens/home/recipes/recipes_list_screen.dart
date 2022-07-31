import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_future_builder.dart';
import 'package:aromatherapy/components/primary_listview_builder.dart';
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
    const RecipesListScreen(),
    const HomeScreen(),
  ];
  int SelectedIndex = 1; //TODO :: enumeration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');
  List<DocumentSnapshot> data = [];
  late final _PrimaryListRecipesState? state;

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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true, // this is all you need
          backgroundColor: kSecondaryBackgroundColor,
          title: const Center(
              child: Text(
            "Essential recipes",
            style: TextStyle(
                color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          controller: ScrollController(
            initialScrollOffset: 0.0,
            keepScrollOffset: true,
          ),
          child: Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, right: 10, left: 10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                  child: Text(
                    'Popular Essential recipes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilderHome(future: recipes, type: 2),
                const SizedBox(
                  height: 20,
                ),
                const Text('Find your favorite'),
                const Text(
                  'Essential Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const PrimaryListRecipes(),
              ],
            ),
          ),
        ));
  }

  Widget BuildRecipes(BuildContext context, String recipeName) {
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
                const Icon(
                  Icons.soup_kitchen,
                  color: kSecondaryColor,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              recipeName,
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

class PrimaryListRecipes extends StatefulWidget {
  const PrimaryListRecipes({Key? key}) : super(key: key);

  @override
  _PrimaryListRecipesState createState() => _PrimaryListRecipesState();
}

class _PrimaryListRecipesState extends State<PrimaryListRecipes> {
  List<DocumentSnapshot> data = [];
  List<DocumentSnapshot> _foundRecipes = [];
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');

  void _runFilter(String enteredKeyword) {
    List<DocumentSnapshot> results = [];
    if (enteredKeyword.isEmpty) {
      results = data;
    } else {
      results = data
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundRecipes = results;
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
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: _foundRecipes.isNotEmpty
              ? ListBuilder(list: _foundRecipes, type: 2)
              : FutureBuilder<QuerySnapshot>(
                  future: recipes.orderBy("name").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      data = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Recipe rec = Recipe.fromMap(
                              Map<String, dynamic>.from(
                                  data[index].data() as Map),
                              data[index].id);
                          return SecondaryItemCardRecipes(
                            text: rec.name,
                            subText: rec.reference.toString(),
                            iconData: Icons.soup_kitchen,
                            iconColor: kSecondaryBackgroundColor,
                            recipe: rec,
                            backgroundColor: kSecondaryColor,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  }),
        ),
      ],
    );
  }
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_top_item_card_rec.dart';
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
                                  Recipe rec = Recipe.fromMap(
                                      Map<String, dynamic>.from(
                                          data[index].data() as Map),
                                      data[index].id);
                                  return PrimaryTopItemCardRecipe(
                                    text: rec.name,
                                    subText: rec.reference.toString(),
                                    imagePath: 'assets/images/recipe.png',
                                    recipe: rec,
                                    backgroundColor: kSecondaryColor,
                                  );
                                },
                              );
                            }
                            return const Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            );
                          }),
                    ),
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
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: _foundoils.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Recipe rec = Recipe.fromMap(
                        Map<String, dynamic>.from(
                            _foundoils[index].data() as Map),
                        _foundoils[index].id);
                    return SecondaryItemCardRecipes(
                      text: rec.name,
                      subText: rec.reference.toString(),
                      imagePath: 'assets/images/recipe.png',
                      recipe: rec,
                      backgroundColor: kSecondaryColor,
                    );
                  },
                )
              : FutureBuilder<QuerySnapshot>(
                  future: oilss.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      data = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                            imagePath: 'assets/images/recipe.png',
                            recipe: rec,
                            backgroundColor: kSecondaryColor,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  }),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

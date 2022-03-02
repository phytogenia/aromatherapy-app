import 'package:aromatherapy/components/primary_top_item_card_rec.dart';
import 'package:aromatherapy/components/secondary_item_cardRecipes.dart';
import 'package:aromatherapy/models/recipe/recipe.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({Key? key}) : super(key: key);

  @override
  _RecipesListScreenState createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  CollectionReference rec = FirebaseFirestore.instance.collection('recipes');
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kPrimaryTextColor, //change your color here
          ),
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
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
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
                      const SizedBox(
                        height: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10),
                        child: Text(
                          'Popular Essential recipes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FutureBuilder<QuerySnapshot>(
                            future: rec.get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                data = snapshot.data!.docs;

                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  itemCount: data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Recipe recipe = Recipe.fromMap(
                                        Map<String, dynamic>.from(
                                            data[index].data() as Map),
                                        data[index].id);
                                    return PrimaryTopItemCardRecipe(
                                      text: recipe.name,
                                      subText: recipe.reference.toString(),
                                      imagePath: 'assets/images/whiteoil.png',
                                      recipe: recipe,
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
                        /* child: PrimaryTopListItems(
                                list: data,
                                backgroundColor: kPrimaryColor,
                                imagePath: 'assets/images/whiteoil.png',
                              ),*/
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
                                  'Recipe',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
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
                                  onChanged: (value) => _runFilter(value),
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: kSecondaryTextColor,
                                    ),
                                    hintText: 'Quick search for recipes ...',
                                    hintStyle: TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: kSecondaryTextColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: kSecondaryColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: _foundUsers.isNotEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      itemCount: _foundUsers.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        Recipe recipe = Recipe.fromMap(
                                            Map<String, dynamic>.from(
                                                _foundUsers[index].data()
                                                    as Map),
                                            _foundUsers[index].id);

                                        return SecondaryItemCardRecipes(
                                            text: _foundUsers[index]["name"]
                                                .toString(),
                                            subText: _foundUsers[index]
                                                    ["sciName"]
                                                .toString(),
                                            imagePath:
                                                'assets/images/whiteoil.png',
                                            recipe: recipe,
                                            backgroundColor: kSecondaryColor);
                                      })
                                  : SizedBox(
                                      height: 120,
                                      child: FutureBuilder<QuerySnapshot>(
                                          future: rec.get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  "Something went wrong");
                                            }

                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              data = snapshot.data!.docs;

                                              return ListView.builder(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                itemCount: data.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  Recipe recipe = Recipe.fromMap(
                                                      Map<String, dynamic>.from(
                                                          data[index].data()
                                                              as Map),
                                                      data[index].id);
                                                  return SecondaryItemCardRecipes(
                                                    text: recipe.name,
                                                    subText:
                                                        recipe.reference.toString(),
                                                    imagePath:
                                                        'assets/images/whiteoil.png',
                                                    recipe: recipe,
                                                    backgroundColor:
                                                        kSecondaryColor,
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
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                Image.asset('assets/images/whiteoil.png')
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

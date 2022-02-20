import 'package:aromatherapy/screens/Oils/ListScreen/ListScreen.dart';
import 'package:aromatherapy/screens/Recipes/ListScreen/ListRecipes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _Screens = [
    const ListScreen(),
    const HomeScreen(),
    const ListRecipes()
  ];
  int SelectedIndex = 1;

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
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xff61BB46),
        index: SelectedIndex,
        items: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/whiteoil.png',
              color: SelectedIndex == 0 ? Colors.white : Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/home.png',
              color: SelectedIndex == 1 ? Colors.white : Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/recipe.png',
              color: SelectedIndex == 2 ? Colors.white : Colors.grey,
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
  List categories = [];
  List oils = [];
  List recipes = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: oils.isEmpty || recipes.isEmpty || categories.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff61BB46),
              ),
            )
          : SafeArea(
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
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff61BB46)),
                                  child: const Center(
                                    child: Text(
                                      'Y',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                color: Colors.white,
                              ),
                              height: 40,
                              child: Center(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Find your Essential oil',
                                    hintStyle: TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.green),
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
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      if (index % 2 == 0) {
                                        return BuildOrangeCategories(
                                            context, categories[index]);
                                      } else {
                                        return BuildGreenCategories(
                                            context, categories[index]);
                                      }
                                    }),
                              ),
                            )
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
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: oils.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return BuildOils(context, oils[index]);
                              })),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: oils.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return BuildRecipes(context, recipes[index]);
                              })),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget BuildRecipes(BuildContext context, String recipename) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(8),
    width: 130,
    decoration: const BoxDecoration(
        color: Color(0xFFE88B00),
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
              Image.asset(
                'assets/images/recipe.png',
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            recipename,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            'Scientific name',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Widget BuildOils(BuildContext context, String oilname) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(8),
    width: 130,
    decoration: const BoxDecoration(
        color: Color(0xff61BB46),
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
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            'Scientific name',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Widget BuildOrangeCategories(BuildContext context, String name) {
  return Container(
    width: 130,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Color(0xFFE88B00)),
        color: Colors.white),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/recipe.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(color: Color(0xFFE88B00)),
          ),
        ],
      ),
    ),
  );
}

Widget BuildGreenCategories(BuildContext context, String name) {
  return Container(
    width: 130,
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Color(0xff61BB46)),
        color: Colors.white),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/greenoil.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(color: Color(0xff61BB46)),
          ),
        ],
      ),
    ),
  );
}

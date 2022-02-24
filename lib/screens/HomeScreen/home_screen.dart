import 'package:aromatherapy/screens/Oils/ListScreen/ListScreen.dart';
import 'package:aromatherapy/screens/Recipes/ListScreen/ListRecipes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/platform_alert_dialog.dart';
import '../../components/primary_category_card.dart';
import '../../services/auth_service.dart';
import '../../utils/constants.dart';

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
                                GestureDetector(
                                  onTap: () {
                                    //TODO:: go to settings
                                    _showDialogToLogout(context);
                                  },
                                  child: Container(
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
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemCount: oils.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _buildOils(context, oils[index]);
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
                                return _buildRecipes(context, recipes[index]);
                              })),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget _buildRecipes(BuildContext context, String recipename) {
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

Widget _buildOils(BuildContext context, String oilname) {
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

void _showDialogToLogout(BuildContext context) async {
  const dialogTitle = 'Logout';
  const dialogContent = 'Do you want to logout ?';
  const cancelTextButton = 'Dismiss';
  const agreeTextButton = 'Logout';

  bool isUserWantToLogout = await PlatformAlertDialog(
    content: dialogTitle,
    title: dialogContent,
    cancelTextButton: cancelTextButton,
    agreeTextButton: agreeTextButton,
  ).show(context);

  if (isUserWantToLogout) {
    _signOutUser(context);
    // Dismiss settings page
  }
}

void _signOutUser(BuildContext context) async {
  final authProvider = context.read<AuthService>();
  try {
    await authProvider.signOut();
  } catch (e) {
    const dialogTitle = 'Logout Error';
    final dialogContent = 'Cause $e Can you please try later ?';
    const cancelTextButton = 'Dismiss';

    PlatformAlertDialog(
      title: dialogTitle,
      content: dialogContent,
      cancelTextButton: cancelTextButton,
    ).show(context);
  }
}

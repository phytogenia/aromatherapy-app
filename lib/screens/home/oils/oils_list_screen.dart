import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_future_builder.dart';
import 'package:aromatherapy/components/primary_listview_builder.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../components/secondary_item_card.dart';
import '../../../models/oil/oil.dart';
import '../home_screen.dart';
import '../recipes/recipes_list_screen.dart';

class HomeOil extends StatefulWidget {
  const HomeOil({Key? key}) : super(key: key);

  @override
  _HomeOilState createState() => _HomeOilState();
}

class _HomeOilState extends State<HomeOil> {
  final _Screens = [
    const OilListScreen(),
    const HomeScreen(),
    const RecipesListScreen()
  ];
  int SelectedIndex = 0; //TODO :: enumeration

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

class OilListScreen extends StatefulWidget {
  const OilListScreen({Key? key}) : super(key: key);

  @override
  _OilListScreenState createState() => _OilListScreenState();
}

class _OilListScreenState extends State<OilListScreen> {
  List oils = [];
  CollectionReference oilss = FirebaseFirestore.instance.collection('oils');
  List<DocumentSnapshot> data = [];
  late final _PrimaryListOilsState? state;

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
            "Essential oils",
            style: TextStyle(
                color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          reverse: true,
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
                    'Popular Essential oils',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilderHome(future: oilss, type: 1),
                const SizedBox(
                  height: 20,
                ),
                const Text('Find your favorite'),
                const Text(
                  'Essential Oil',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const PrimaryListOils(),
              ],
            ),
          ),
        ));
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
  CollectionReference oilss = FirebaseFirestore.instance.collection('oils');

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
                hintText: 'Quick search for oils ...',
                hintStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: kSecondaryTextColor),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: kPrimaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: _foundoils.isNotEmpty
              ? ListBuilder(list: _foundoils, type: 1)
              : FutureBuilder<QuerySnapshot>(
                  future: oilss.orderBy("name").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      data = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Oil oil = Oil.fromMap(
                              Map<String, dynamic>.from(
                                  data[index].data() as Map),
                              data[index].id);
                          return SecondaryItemCard(
                            text: oil.name,
                            subText: oil.sciName.toString(),
                            imagePath: 'assets/images/whiteoil.png',
                            oil: oil,
                            backgroundColor: kPrimaryColor,
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

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:aromatherapy/components/primary_future_builder.dart';
import 'package:aromatherapy/components/primary_listview_builder.dart';
import 'package:aromatherapy/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../components/primary_top_item_card.dart';
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
    setState(() {
    });
  }
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
            "Essential oils",
            style: TextStyle(
                color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 90),
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
                      height: 40,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                      child: Text(
                        'Popular Essential oils',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilderHome(future: oilss, type: 1),
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
                                'Essential Oil',
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
        Container(
          height: MediaQuery.of(context).size.shortestSide,
          padding: const EdgeInsets.only(bottom: 40),
          child: _foundoils.isNotEmpty
              ? ListBuilder(list: _foundoils, type: 1)
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
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

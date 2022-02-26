import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({Key? key}) : super(key: key);

  @override
  _RecipesListScreenState createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  List oils = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      oils.addAll(['Oil 1', 'Oil 2', 'Oil 3', 'Oil 4', 'Oil 5', 'Oil 6']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kPrimaryTextColor, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
              child: Text(
            "Recipes",
            style: TextStyle(
                color: kPrimaryTextColor, fontWeight: FontWeight.bold),
          )),
        ),
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: oils.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              )
            : SafeArea(
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
                          SizedBox(
                            height: 50,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10),
                            child: Text(
                              'Popular Essential Recipes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  itemCount: oils.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return BuildOils(context, oils[index]);
                                  })),
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
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: kSecondaryTextColor,
                                        ),
                                        hintText: 'Quick search for oils ...',
                                        hintStyle: TextStyle(fontSize: 12),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: kSecondaryTextColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: kSecondaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        itemCount: oils.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return BuildOil(context, oils[index]);
                                        })),
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

  Widget BuildOil(BuildContext context, String oilname) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(color: kSecondaryTextColor),
              color: kSecondaryBackgroundColor),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  oilname,
                  style: const TextStyle(
                      color: kPrimaryTextColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Scientific name',
                  style: TextStyle(color: kPrimaryTextColor),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/whiteoil.png'),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

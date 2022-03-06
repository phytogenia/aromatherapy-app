import 'package:aromatherapy/models/oil/oil.dart';
import 'package:aromatherapy/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../components/primary_list_properties.dart';
import '../../../components/primary_property_description_card.dart';
import '../../../components/primary_property_item.dart';
import '../../../utils/constants.dart';

class RecipesDetails extends StatefulWidget {
  const RecipesDetails(
      {Key? key, required this.recipe}
      ) : super(key: key);
  final Recipe recipe;

  @override
  _RecipesDetailsState createState() => _RecipesDetailsState();
}

class _RecipesDetailsState extends State<RecipesDetails> {
  String name='';
  List<String> otherNames=[];
  String sciName='';
  String? distilledOrgan;
  String? extractionProcess;

  int SelectedIndex = 0;
  List<String> aspect =[];

  List<String> colo = [];
  List<String> odor = [];
  List<String> allergie = [];
  String s='';
  String p='';
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      final Recipe recipe = widget.recipe;
      //aspect.addAll(recipe.aspect);
      //colo.addAll(recipe.color);
      //odor.addAll(recipe.smell);
      //allergie=recipe.allergies;
      name=recipe.name;
      //otherNames=recipe.otherNames;
      sciName = recipe.reference!;
      s = otherNames.join(', ');
      p = allergie.join(', ');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kSecondaryBackgroundColor, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "Recipes",
            style: TextStyle(
                color: kSecondaryBackgroundColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          bottom: false,
          top: false,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width, 130.0)),
                        image: const DecorationImage(
                            colorFilter: ColorFilter.mode(
                                kSecondaryColor, BlendMode.srcOver),
                            image: AssetImage('assets/images/pictop.jpg'),
                            fit: BoxFit.cover)),
                  ), // Picture on top background

                  Positioned(
                      left: 20,
                      right: 20,
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        decoration: const BoxDecoration(
                            color: kSecondaryBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: kSecondaryTextColor,
                                  offset: Offset(2, 2),
                                  blurRadius: 16)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    sciName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: kSecondaryTextColor,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Divider(
                                  indent: 60,
                                  thickness: 1,
                                  endIndent: 60,
                                  color: kSecondaryColor,
                                ),

                                SelectedIndex == 0
                                    ? ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 500, minHeight: 56.0),
                                    child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),

                                        shrinkWrap: true,
                                        itemCount: 1,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return PrimaryPropertyDescriptionCard(
                                            title: "odor[index]",
                                            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry." +
                                                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s," +
                                                "When an unknown printer took a galley of type Scrambled it to make a type specimen book." +
                                                "It has survived not only five centuries" +
                                                "When an unknown printer took a galley of type Scrambled it to make a type specimen book.",
                                          );
                                        }))
                                    : const SizedBox(
                                  height: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

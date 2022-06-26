import 'package:aromatherapy/components/primary_top_item_card.dart';
import 'package:aromatherapy/components/primary_top_item_card_rec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/oil/oil.dart';
import '../models/recipe/recipe.dart';
import '../utils/constants.dart';

class FutureBuilderHome extends StatelessWidget {
  const FutureBuilderHome({Key? key, required this.future, required this.type})
      : super(key: key);
  final CollectionReference future;
  final int type;

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> data;

    return SizedBox(
      height: 120,
      child: FutureBuilder<QuerySnapshot>(
          future: future.orderBy("name").get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              data = snapshot.data!.docs;

              return ListView.builder(
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: type == 1
                      ? (context, index) {
                          Oil oil = Oil.fromMap(
                              Map<String, dynamic>.from(
                                  data[index].data() as Map),
                              data[index].id);
                          return PrimaryTopItemCard(
                            text: oil.name,
                            subText: oil.sciName.toString(),
                            iconColor: kSecondaryBackgroundColor,
                            iconData: Icons.water_drop,
                            oil: oil,
                            backgroundColor: kPrimaryColor,
                          );
                        }
                      : (context, index) {
                          Recipe recipe = Recipe.fromMap(
                              Map<String, dynamic>.from(
                                  data[index].data() as Map),
                              data[index].id);
                          return PrimaryTopItemCardRecipe(
                            text: recipe.name,
                            subText: recipe.reference.toString(),
                            iconData: Icons.soup_kitchen,
                            iconColor: kSecondaryBackgroundColor,
                            recipe: recipe,
                            backgroundColor: kSecondaryColor,
                          );
                        });
            }
            return const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }),
    );
  }
}

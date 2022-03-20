import 'package:aromatherapy/components/secondary_item_card.dart';
import 'package:aromatherapy/components/secondary_item_cardRecipes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/oil/oil.dart';
import '../models/recipe/recipe.dart';
import '../utils/constants.dart';

class FutureBuilderSecond extends StatelessWidget {
  const FutureBuilderSecond(
      {Key? key, required this.future, required this.type})
      : super(key: key);
  final CollectionReference future;
  final int type;

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> data;

    return FutureBuilder<QuerySnapshot>(
        future: future.get(),
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
              itemBuilder: type == 1
                  ? (context, index) {
                      Oil oil = Oil.fromMap(
                          Map<String, dynamic>.from(data[index].data() as Map),
                          data[index].id);
                      return SecondaryItemCard(
                        text: oil.name,
                        subText: oil.sciName.toString(),
                        imagePath: 'assets/images/whiteoil.png',
                        oil: oil,
                        backgroundColor: kPrimaryColor,
                      );
                    }
                  : (context, index) {
                      Recipe rec = Recipe.fromMap(
                          Map<String, dynamic>.from(data[index].data() as Map),
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
        });
  }
}

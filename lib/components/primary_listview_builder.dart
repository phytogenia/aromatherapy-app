import 'dart:io';

import 'package:aromatherapy/components/secondary_item_card.dart';
import 'package:aromatherapy/components/secondary_item_cardRecipes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/oil/oil.dart';
import '../models/recipe/recipe.dart';
import '../utils/constants.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({Key? key, required this.list, required this.type}) : super(key: key);

  final List<DocumentSnapshot> list;
  final int type;

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
     shrinkWrap: true,
     padding: const EdgeInsets.symmetric(horizontal: 15),
     itemCount: list.length,
     scrollDirection: Axis.vertical,
     itemBuilder: type==1? (context, index) {
       Oil oil = Oil.fromMap(
           Map<String, dynamic>.from(
               list[index].data() as Map),
           list[index].id);
       return SecondaryItemCard(
         text: oil.name,
         subText: oil.sciName.toString(),
         imagePath: 'assets/images/whiteoil.png',
         oil: oil,
         backgroundColor: kPrimaryColor,
       );
     }: (context, index) {
       Recipe rec = Recipe.fromMap(
           Map<String, dynamic>.from(
               list[index].data() as Map),
           list[index].id);
       return SecondaryItemCardRecipes(
         text: rec.name,
         subText: rec.reference.toString(),
         imagePath: 'assets/images/recipe.png',
         recipe: rec,
         backgroundColor: kSecondaryColor,
       );
     }
   );
}}

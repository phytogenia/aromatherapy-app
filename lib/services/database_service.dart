import 'dart:core';

import '../models/oil/oil.dart';
import '../models/recipe/recipe.dart';
import 'api_path.dart';
import 'firebase_service.dart';

abstract class DatabaseService {
  Stream<List<Oil>> streamOils();
  Stream<List<Recipe>> streamRecipes();
}

class FirebaseDatabaseService implements DatabaseService {
  final String uid;
  FirebaseDatabaseService({required this.uid});

  @override
  Stream<List<Oil>> streamOils() {
    final _service = FirebaseService.instance;
    return _service.getStreamListCollection<Oil>(
        path: APIPath.oils(),
        builder: (data, documentID) => Oil.fromMap(data, documentID));
  }

  @override
  Stream<List<Recipe>> streamRecipes() {
    final _service = FirebaseService.instance;
    return _service.getStreamListCollection<Recipe>(
        path: APIPath.recipes(),
        builder: (data, documentID) => Recipe.fromMap(data, documentID));
  }

  //TODO:: add streamRecipes
/*  @override
  Stream<List<OilDomain>> streamOilDomain(String oilId, String domainType) {
    final _service = FirebaseService.instance;

    return _service.getOilDomainDocument(
        oilId: oilId,
        domainType: domainType,
        path: APIPath.oilDomains(),
        builder: (data, documentID) => OilDomain.fromMap(data, documentID));
  }*/
}

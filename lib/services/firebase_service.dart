import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirebaseService {
  FirebaseService._();
  static final instance = FirebaseService._();

  Future<void> setData({
    required String? documentID,
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (documentID != null) {
        // Edit
        DocumentReference<Map<String, dynamic>> _document =
            FirebaseFirestore.instance.doc(path);
        print('$path : $data');
        await _document.set(data);
      } else {
        // Create
        CollectionReference<Map<String, dynamic>> _document =
            FirebaseFirestore.instance.collection(path);
        print('$path : $data');
        await _document.add(data);
      }
    } on FirebaseException catch (e) {
      throw PlatformException(
          code: e.code, details: e.plugin, message: e.message);
    }
  }

  Stream<List<T>> getStreamListCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final _collection = FirebaseFirestore.instance.collection(path);
    final _snapshot = _collection.snapshots();
    return _snapshot.map((collection) => collection.docs
        .map(
          (document) => builder(document.data(), document.id),
        )
        .toList());
  }

  //TODO :: make it generic
  /*Stream<List<T>> getOilDomainDocument<T>({
    required String oilId,
    required String domainType,
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final _collection = FirebaseFirestore.instance.collection(path);
    final _snapshot = _collection
        .where('oilId', isEqualTo: oilId)
        .where('type', isEqualTo: domainType)
        .get()
        .asStream();
    return _snapshot.map((collection) => collection.docs
        .map(
          (document) => builder(document.data(), document.id),
        )
        .toList());
  }*/
}

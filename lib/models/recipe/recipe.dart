import 'ingredient.dart';
import 'ingredient.dart';

class Recipe {
  String? id;
  String name;
  String? reference;
  List<String?>? ingredients;
  String? description;
  String? notes;
  String? usage;

  Recipe({
    this.id,
    required this.name,
    this.reference,
    this.ingredients,
    this.description,
    this.notes,
    this.usage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'reference': reference,
      'ingredients': ingredients,
      'description': description,
      'notes': notes,
      'usage': usage,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic>? data, String documentID) {
    String name = data!['name'].toString();
    String? reference = data['reference'];
    List<String?>? ingredients;
    for (var ingredient in data['ingredients']) {
      ingredients?.add(ingredient['name']);
    }

    String? description = data['description'];
    String? notes = data['notes'];
    String? usage = data['usage'];

    return Recipe(
      id: documentID,
      name: name,
      reference: reference,
      ingredients: ingredients,
      description: description,
      notes: notes,
      usage: usage,
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}

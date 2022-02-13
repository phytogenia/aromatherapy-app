class Ingredient {
  String name;

  Ingredient({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic>? data) {
    String name = data!['name'].toString();
    return Ingredient(
      name: name,
    );
  }

  @override
  String toString() {
    return 'name: $name';
  }
}

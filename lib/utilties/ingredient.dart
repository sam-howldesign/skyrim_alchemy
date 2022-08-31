class Ingredient {
  final int id;
  final String name;
  final String link;

  const Ingredient({
    required this.id,
    required this.name,
    required this.link,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      id: json['id'],
      link: json['link'],
    );
  }
}

class Effect {
  final int id;
  final String name;

  const Effect({
    required this.id,
    required this.name,
  });

  factory Effect.fromJson(Map<String, dynamic> json) {
    return Effect(
      name: json['name'],
      id: json['id'],
    );
  }
}

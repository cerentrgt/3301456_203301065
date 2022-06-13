class ExampleWords {
  String name;
  String imageUrl;
  ExampleWords({
    required this.name,
    required this.imageUrl,
  });

  factory ExampleWords.fromJson(Map<String, dynamic> map) {
    return ExampleWords(
      name: map["name"]["first"],
      imageUrl: map["picture"]["medium"],
    );
  }

  @override
  String toString() => 'Student(name: $name, imageUrl: $imageUrl)';
}

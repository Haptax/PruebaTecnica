class CardModel {
  final int id;
  final String name;
  final String type;
  final String description;
  final String imageUrl;

  CardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.imageUrl,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['desc'],
      imageUrl: json['card_images'][0]['image_url'],
    );
  }
}

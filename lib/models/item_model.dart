class ItemModel {
  final String itemId;
  final String image;
  final String title;
  final String description;
  final String? externalSourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemModel({
    required this.itemId,
    required this.image,
    required this.title,
    required this.description,
    this.externalSourceUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['item_id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      externalSourceUrl: json['external_source_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'image': image,
      'title': title,
      'description': description,
      'external_source_url': externalSourceUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

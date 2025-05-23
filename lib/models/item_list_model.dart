class ItemListModel {
  final String itemId;
  final String title;
  final String? shortTitle;

  ItemListModel({
    required this.itemId,
    required this.title,
    this.shortTitle,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> json) {
    return ItemListModel(
      itemId: json['item_id'] as String,
      title: json['title'] as String,
      shortTitle: json['short_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'title': title,
      'short_title': shortTitle,
    };
  }
}
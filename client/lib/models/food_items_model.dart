class GetAllFoodItemsModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final dynamic imageUrl;
  final bool isAvailable;

  GetAllFoodItemsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory GetAllFoodItemsModel.fromJson(Map<String, dynamic> json) =>
      GetAllFoodItemsModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: double.tryParse(json["price"].toString()) ?? 0.0,
        category: json["category"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "image_url": imageUrl,
    "is_available": isAvailable,
  };
}

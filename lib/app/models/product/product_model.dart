class ProductModel {
  final int id;
  final String name;
  final String description;
  // final double price;
  final String imageUrl;
  final String category;
  final String nutrition;
  final String link;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    // required this.price,
    required this.imageUrl,
    required this.category,
    required this.nutrition,
    required this.link,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      // price: json['price'],
      imageUrl: json['product_img'],
      category: json['category_name'],
      nutrition: json['nutrition'],
      link: json['link_product'],
    );
  }
}

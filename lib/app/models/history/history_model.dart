import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';

class HistoryModel {
  final int id;
  final String disease;
  final String description;
  final String image;
  final int user;
  final String solution;
  final String date;
  final List<ProductModel> products;

  HistoryModel({
    required this.id,
    required this.user,
    required this.disease,
    required this.description,
    required this.image,
    required this.solution,
    required this.date,
    required this.products,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    var productList = (json['products'] as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();

    return HistoryModel(
      id: json['id'],
      user: json['userId'],
      disease: json['disease'],
      description: json['description_disease'],
      solution: json['solution_disease'],
      image: json['face_img'],
      date: json['created_at'],
      products: productList,
    );
  }
}

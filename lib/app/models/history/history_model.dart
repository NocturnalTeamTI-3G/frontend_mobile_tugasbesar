class HistoryModel {
  final int id;
  final String disease;
  final String description;
  final String image;
  final int user;
  final String solution;
  final String product;
  final String productDesc;

  HistoryModel({
    required this.id,
    required this.user,
    required this.disease,
    required this.description,
    required this.image,
    required this.solution,
    required this.product,
    required this.productDesc,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      user: json['userId'],
      disease: json['disease'],
      description: json['description_disease'],
      solution: json['solution_disease'],
      product: json['product'],
      productDesc: json['description_product'],
      image: json['face_img'],
    );
  }
}

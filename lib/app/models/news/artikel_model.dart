class ArtikelModel {
  final int id;
  final String title;
  final String content;
  final String image;
  final String date;
  final String author;
  final String authorImg;
  final int views;
  final int likes;
  final String category;

  ArtikelModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.author,
    required this.authorImg,
    required this.views,
    required this.likes,
    required this.category,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['post_img'],
      date: json['updated_at'],
      author: json['username'],
      authorImg: json['profile_img'],
      views: json['views'],
      likes: json['likes'],
      category: json['category_name'],
    );
  }
}

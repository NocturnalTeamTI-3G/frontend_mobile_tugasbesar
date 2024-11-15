class ArtikelModel {
  final int id;
  final String title;
  final String content;
  final String image;
  final String date;
  final String author;
  final int authorId;
  final int catId;
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
    required this.authorId,
    required this.catId,
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
      author: json['user_name'],
      authorId: json['user_id'],
      authorImg: json['user_img'],
      views: json['views'],
      likes: json['likes'],
      category: json['category_name'],
      catId: json['category_id'],
    );
  }
}

class ArtikelType {
  final String id;
  final String title;
  final String content;
  final String image;
  final String date;
  final String author;
  final String authorImg;

  ArtikelType({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.author,
    required this.authorImg,
  });

  factory ArtikelType.fromJson(Map<String, dynamic> json) {
    return ArtikelType(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      date: json['date'],
      author: json['author'],
      authorImg: json['authorImg'],
    );
  }
}

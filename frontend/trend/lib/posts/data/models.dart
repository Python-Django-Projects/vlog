class PostModel {
  final int id;
  final int author;
  final String image;
  final String description;
  // final int like_count;
  // final DateTime created_at;
  // final DateTime updated_at;
  // final int likes;
  // final int share;

  PostModel({
    required this.id,
    required this.author,
    required this.image,
    required this.description,
    // required this.like_count,
    // required this.created_at,
    // required this.updated_at,
    // required this.likes,
    // required this.share,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      author: json['author'],
      image: json['image'],
      description: json['description'],
      // like_count: json['like_count'],
      // created_at: DateTime.parse(json['created_at']),
      // updated_at: DateTime.parse(json['updated_at']),
      // likes: json['likes'] ?? 0,
      // share: json['share'] ?? 0,
    );
  }
}

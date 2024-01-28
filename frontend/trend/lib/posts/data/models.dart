class PostModel {
  final int id;
  final String author;
  final String image;
  final String description;
  final String created_at;
  final String updated_at;
  final String likes;
  final String share;

  PostModel(
      {required this.id,
      required this.author,
      required this.image,
      required this.description,
      required this.created_at,
      required this.updated_at,
      required this.likes,
      required this.share});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        author: json['author'],
        image: json['image'],
        description: json['description'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        likes: json['likes'],
        share: json['share']);
  }
}

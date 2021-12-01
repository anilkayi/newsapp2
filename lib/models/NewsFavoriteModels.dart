class NewsFavorite {
  String? title;
  String? description;
  String? urltoImage;
  String? source;

  NewsFavorite(this.title, this.description, this.urltoImage, this.source);

  factory NewsFavorite.fromJson(Map<dynamic, dynamic> json) {
    return NewsFavorite(
        json["title"], json["description"], json["urlToImage"], json["source"]);
  }
}

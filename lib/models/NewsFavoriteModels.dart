class NewsFavorite {
  String? title;
  String? description;
  String? urltoImage;
  String? source;
  String? id;

  NewsFavorite(
      this.id, this.title, this.description, this.urltoImage, this.source);

  factory NewsFavorite.fromJson(key, Map<dynamic, dynamic> json) {
    return NewsFavorite(key, json["title"], json["description"],
        json["urlToImage"], json["source"]);
  }
}

class NewsFavorite {
  String? data_id;
  String? title;
  String? description;
  String? urltoImage;
  String? source;

  NewsFavorite(
      this.data_id, this.title, this.description, this.urltoImage, this.source);

  factory NewsFavorite.fromJson(String key, Map<dynamic, dynamic> json) {
    return NewsFavorite(
        key,
        json["title"] as String,
        json["description"] as String,
        json["urltoImage"] as String,
        json["source"] as String);
  }
}

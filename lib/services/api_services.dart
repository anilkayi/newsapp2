import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp2/models/NewsModels.dart';

const apikey = '456495b331014c42b9fb071ba9b26e5e';

class NewsServices {
  Future<List<Article>> getNews(String country) async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apikey"));

    var data = jsonDecode(response.body);

    List<Article> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        Article _artcileModel = Article.fromJson(item);
        _articleModelList.add(_artcileModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList = []; // empty list

    }
  }
}

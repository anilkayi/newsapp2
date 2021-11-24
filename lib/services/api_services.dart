import 'dart:convert';

import 'package:http/http.dart';
import 'package:newsapp2/models/NewsModels.dart';

const apikey = '456495b331014c42b9fb071ba9b26e5e';

class NewsServices {
  Future<NewsModels> getNews() async {
    var url = await Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=tr&apiKey=$apikey');
    var response = await get(url);
    var body = jsonDecode(response.body);
    print('${response.body}');
    return NewsModels.fromJson(body);
  }
}

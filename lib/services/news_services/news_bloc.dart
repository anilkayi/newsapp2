import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:newsapp2/models/NewsModels.dart';

const apikey = '456495b331014c42b9fb071ba9b26e5e';

enum NewsAction { GET, DELETE }

class NewBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.GET) {
        try {
          var news = await getNews();
          _newsSink.add(news.articles!.toList());
        } catch (e) {
          _newsSink.addError('Something went wrong');
        }
      }
    });
  }
}

Future<NewsModels> getNews() async {
  var url = await Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=tr&apiKey=$apikey');
  var response = await get(url);
  var body = jsonDecode(response.body);
  print('${response.body}');
  return NewsModels.fromJson(body);
}

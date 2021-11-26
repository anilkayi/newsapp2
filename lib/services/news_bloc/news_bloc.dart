import 'package:newsapp2/models/NewsModels.dart';
import 'package:newsapp2/services/api_services.dart';
import 'package:newsapp2/services/news_bloc/news_event.dart';
import 'package:newsapp2/services/news_bloc/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsServices newsServices;

  NewsBloc(NewsStates initialState, this.newsServices) : super(initialState) {
    on((NewsEvents event, Emitter<NewsStates> emit) async {
      if (event is StartEvent) {
        try {
          List<Article> _articleList;
          emit(
            NewsInitState(),
          );
          _articleList = (await newsServices.getNews());
          emit(
            NewsLoadedState(articleList: _articleList),
          );
        } catch (e) {
          emit(
            NewsErrorState(errorMessage: e.toString()),
          );
        }
      }
    });
  }
}

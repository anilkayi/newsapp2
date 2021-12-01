import 'package:newsapp2/UI/theme/app_themes.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_event.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeStates> {
  ThemeBloc() : super(ThemeStates(theme: AppTheme.lightTheme)) {
    on((ThemeEvent event, Emitter<ThemeStates> emit) async {
      if (event is ThemeEvent) {
        emit(ThemeStates(theme: event.theme));
      }
    });
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:newsapp2/UI/logIn_page.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_bloc.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_state.dart';
import 'package:newsapp2/services/api_services.dart';
import 'package:newsapp2/services/news_bloc/news_bloc.dart';
import 'package:newsapp2/services/news_bloc/news_state.dart';
import 'package:newsapp2/generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(NewsInitState(), NewsServices()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeStates>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              //GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.theme,
            home: Login(),
          );
        },
      ),
    );
  }
}

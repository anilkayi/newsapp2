import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp2/UI/HomePage.dart';
import 'package:newsapp2/UI/settings/language/languages.dart';
import 'package:newsapp2/UI/theme/app_themes.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_bloc.dart';
import 'package:newsapp2/UI/theme/theme_bloc/theme_event.dart';
import 'package:newsapp2/generated/l10n.dart';

Language lng = Language();

class Settings extends StatefulWidget {
  String user;

  Settings(this.user);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void showModelBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        S.delegate.load(S.delegate.supportedLocales[index]);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    widget.user,
                                    (S.delegate.supportedLocales[index]
                                        .countryCode
                                        .toString()))));
                      });
                    },
                    child: Container(child: Text(lng.Languages[index]))),
              );
            },
            itemCount: lng.Languages.length,
          );
        });
  }

  int max = 15;
  int min = 10;
  AppTheme themeData = AppTheme();
  double value = 15;
  bool isThemeSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(S.of(context).settingTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 110),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(S.of(context).themaTitle),
                      Switch(
                          onChanged: (value) {
                            if (isThemeSwitch) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ThemeEvent(theme: AppTheme.lightTheme));
                            } else {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ThemeEvent(theme: AppTheme.darkTheme));
                            }
                            isThemeSwitch = value;
                            setState(() {});
                          },
                          value: isThemeSwitch),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModelBottom(context);
                    },
                    child: Container(
                      child: Text(
                        S.of(context).languageTitle,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      buildSideLabe(min.toDouble()),
                      Expanded(
                        child: Slider(
                            divisions: 5,
                            label: value.round().toString(),
                            value: value,
                            onChanged: (double s) {
                              setState(() {
                                value = s;
                              });
                              BlocProvider.of<ThemeBloc>(context).add(
                                  ThemeEvent(
                                      theme: themeData.fontTheme(
                                          MediaQuery.of(context).size.width *
                                              0.0035 *
                                              value)));
                            },
                            max: max.toDouble(),
                            min: min.toDouble()),
                      ),
                      buildSideLabe(max.toDouble())
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSideLabe(double value) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.05,
        child: Text(value.round().toString()));
  }
}

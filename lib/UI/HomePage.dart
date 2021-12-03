import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:newsapp2/UI/UserPage.dart';
import 'package:newsapp2/UI/logIn_page.dart';
import 'package:newsapp2/UI/settings/settings.dart';
import 'package:newsapp2/models/NewsFavoriteModels.dart';
import 'package:newsapp2/models/NewsModels.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_favorite.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_favorite_service.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_removefavorite_service.dart';
import 'package:newsapp2/services/news_bloc/news_bloc.dart';
import 'package:newsapp2/services/news_bloc/news_event.dart';
import 'package:newsapp2/generated/l10n.dart';
import 'package:newsapp2/services/news_bloc/news_state.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newsapp2/style.dart';

enum PushPage { home_page, my_profile, settings_page, logout_page }

class HomePage extends StatefulWidget {
  String country;
  String user;

  HomePage(this.user, this.country);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsBloc? bloc;
  FavoriteClass addFav = FavoriteClass();
  UserFavorite newsFavorite = UserFavorite();
  RemoveFavorite remove = RemoveFavorite();
  List<bool> boolList = [];

  var refFavorite = FirebaseDatabase.instance.reference().child('Favorite');
  @override
  void initState() {
    bloc = BlocProvider.of<NewsBloc>(context);
    bloc!.add(StartEvent(widget.country));
    BlocProvider.of<NewsBloc>(context).newsServices.getNews(widget.country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: Text(
                      widget.user[0].toUpperCase(),
                      style: buildTextStyle(25, Colors.white, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email: ${widget.user}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              )),
            ),
            buildListTile(S.of(context).homepageTitle, Icons.home,
                HomePage(widget.user, widget.country), PushPage.home_page),
            buildListTile(S.of(context).profileTitle, Icons.person, UserPage(),
                PushPage.my_profile),
            buildListTile(S.of(context).settingTitle, Icons.settings,
                Settings(widget.user), PushPage.settings_page),
            buildListTile(S.of(context).logoutTitle, Icons.exit_to_app, Login(),
                PushPage.logout_page),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<NewsBloc, NewsStates>(
          builder: (BuildContext context, NewsStates state) {
            if (state is NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoadedState) {
              List<Article> _articleList;
              _articleList = state.articleList;
              _articleList.forEach((element) {
                boolList.add(false);
              });
              return ListView.builder(
                  itemBuilder: (context, indeks) {
                    initializeDateFormatting('tr');
                    return Card(
                        child: Column(
                      children: [
                        Image.network(
                            _articleList[indeks].urlToImage.toString()),
                        Text(DateFormat.yMMMEd('tr_TR')
                            .format(DateTime.now())
                            .toString()),
                        ExpansionTile(
                          title: Text(_articleList[indeks].title.toString()),
                          subtitle: Text(
                              _articleList[indeks].source!.name.toString()),
                          trailing: boolList[indeks]
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      boolList[indeks] = false;
                                      print('tıklandi,false');
                                    });
                                    remove.removeFav(_articleList[indeks]
                                        .data_id
                                        .toString());
                                  },
                                  icon: Icon(Icons.cancel))
                              : IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      boolList[indeks] = true;
                                      print('tıklandi');
                                    });
                                    addFav.AddFavorite(
                                        _articleList[indeks]
                                            .urlToImage
                                            .toString(),
                                        _articleList[indeks].title.toString(),
                                        _articleList[indeks]
                                            .source!
                                            .name
                                            .toString(),
                                        _articleList[indeks]
                                            .description
                                            .toString());
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                  )),
                          children: [
                            ListTile(
                              title: Text(
                                  _articleList[indeks].description.toString()),
                            )
                          ],
                        ),
                      ],
                    ));
                  },
                  itemCount: _articleList.length);
            } else if (state is NewsErrorState) {
              String error = state.errorMessage;
              return Center(
                child: Text(error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  ListTile buildListTile(
      String yazi, IconData icon, dynamic Sayfa, PushPage page) {
    return ListTile(
      title: Text(yazi),
      leading: Icon(icon),
      onTap: () {
        switch (page) {
          case PushPage.home_page:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            break;
          case PushPage.my_profile:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            break;
          case PushPage.settings_page:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            break;
          case PushPage.logout_page:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Sayfa));
        }
      },
    );
  }
}

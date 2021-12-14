import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:newsapp2/UI/CommentPage.dart';
import 'package:newsapp2/UI/UserPage.dart';
import 'package:newsapp2/UI/logIn_page.dart';
import 'package:newsapp2/UI/message/messaging_widget.dart';
import 'package:newsapp2/UI/settings/settings.dart';
import 'package:newsapp2/models/NewsModels.dart';
import 'package:newsapp2/models/messagemodels.dart';
import 'package:newsapp2/services/firebase_comment/add_comment.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_favorite.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_removefavorite_service.dart';
import 'package:newsapp2/services/news_bloc/news_bloc.dart';
import 'package:newsapp2/services/news_bloc/news_event.dart';
import 'package:newsapp2/generated/l10n.dart';
import 'package:newsapp2/services/news_bloc/news_state.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newsapp2/style.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; //

void main() {
  var bytes = utf8.encode("foobar"); // data being hashed

  var digest = sha1.convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
}

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
  RemoveFavorite remove = RemoveFavorite();
  List<bool> boolList = [];
  AddComment comment = AddComment();
  TextEditingController commentController = TextEditingController();
  NotificationMessage ntf = NotificationMessage();
  RemoveFavorite removeFav = RemoveFavorite();
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
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
                  itemBuilder: (context, index) {
                    initializeDateFormatting('tr');
                    return Card(
                        child: Column(
                      children: [
                        FadeInImage(
                          image: NetworkImage(
                              _articleList[index].urlToImage.toString()),
                          imageErrorBuilder: (ctx, exception, stackTrace) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Image.asset(
                                'assets/images/no.png',
                              ),
                            );
                          },
                          placeholder: AssetImage('assets/images/no.png'),
                        ),
                        Text(DateFormat.yMMMEd('tr_TR')
                            .format(DateTime.now())
                            .toString()),
                        ExpansionTile(
                          title: Text(_articleList[index].title.toString()),
                          subtitle:
                              Text(_articleList[index].source!.name.toString()),
                          trailing: boolList[index]
                              ? IconButton(
                                  onPressed: () {
                                    if (boolList[index] == true) {
                                      Fluttertoast.showToast(
                                          msg: 'Zaten favoriye eklendi');
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ))
                              : IconButton(
                                  onPressed: () async {
                                    if (boolList[index] == true) {
                                      Fluttertoast.showToast(
                                          msg: 'Zaten favoriye eklendi');
                                    } else {
                                      var bytes = utf8.encode(
                                          _articleList[index].url.toString());
                                      var sha = sha1.convert(bytes);
                                      sha1.convert(bytes);
                                      setState(() {
                                        boolList[index] = true;
                                      });
                                      addFav.AddFavorite(
                                          _articleList[index]
                                              .urlToImage
                                              .toString(),
                                          _articleList[index].title.toString(),
                                          _articleList[index]
                                              .source!
                                              .name
                                              .toString(),
                                          _articleList[index]
                                              .description
                                              .toString(),
                                          sha.toString());
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.grey,
                                  )),
                          children: [
                            ListTile(
                              title: TextButton(
                                onPressed: () {
                                  var bytes = utf8.encode(
                                      _articleList[index].url.toString());
                                  var sha = sha1.convert(bytes);
                                  sha1.convert(bytes);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommentPage(
                                              sha.toString(),
                                              widget.user,
                                              _articleList[index]
                                                  .urlToImage
                                                  .toString(),
                                              _articleList[index]
                                                  .title
                                                  .toString())));
                                },
                                child: Text(
                                    'Detayları görmek ve yorum yapmak için tıklayınız...'),
                              ),
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
            scaffoldKey.currentState!.openEndDrawer();

            break;
          case PushPage.my_profile:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            scaffoldKey.currentState!.openEndDrawer();
            break;
          case PushPage.settings_page:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            scaffoldKey.currentState!.openEndDrawer();
            break;
          case PushPage.logout_page:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Sayfa));
            scaffoldKey.currentState!.openEndDrawer();
        }
      },
    );
  }
}

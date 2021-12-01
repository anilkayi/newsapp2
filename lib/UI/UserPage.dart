import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp2/UI/HomePage.dart';
import 'package:newsapp2/models/NewsFavoriteModels.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_favorite_service.dart';
import 'package:newsapp2/generated/l10n.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserFavorite newsFavorite = UserFavorite();
  @override
  void initState() {
    newsFavorite.favoriteNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(S.of(context).profileTitle),
      ),
      body: SafeArea(
        child: StreamBuilder<Event>(
          stream: newsFavorite.refFavorite.onValue,
          builder: (context, event) {
            if (event.hasData) {
              var favNewsList = <NewsFavorite>[];
              var dataFavNews = event.data!.snapshot.value;
              if (dataFavNews != null) {
                dataFavNews.forEach((key, value) {
                  var newsdata = NewsFavorite.fromJson(value);
                  favNewsList.add(newsdata);
                });
              }
              return ListView.builder(
                itemBuilder: (context, indeks) {
                  return Card(
                      child: Column(
                    children: [
                      FadeInImage(
                        image: NetworkImage(
                            favNewsList[indeks].urltoImage.toString()),
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
                        title: Text(favNewsList[indeks].title.toString()),
                        subtitle: Text(favNewsList[indeks].source!.toString()),
                        children: [
                          ListTile(
                            title: Text(
                                favNewsList[indeks].description.toString()),
                          )
                        ],
                      ),
                    ],
                  ));
                },
                itemCount: favNewsList.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

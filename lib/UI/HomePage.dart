import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp2/UI/logIn_page.dart';
import 'package:newsapp2/UI/signIn_page.dart';
import 'package:newsapp2/models/NewsModels.dart';
import 'package:newsapp2/services/firebase_favorite/firebase_favorite.dart';
import 'package:newsapp2/services/news_services/news_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsBloc = NewBloc();
  final addFavorite = FavoriteClass();
  @override
  void initState() {
    newsBloc.eventSink.add(NewsAction.GET);
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
            UserAccountsDrawerHeader(
              accountEmail: Text('Deneme@gmail.com'),
              accountName: Text('Anil Kayi'),
              currentAccountPicture: CircleAvatar(
                child: Text('A'),
                backgroundColor: Colors.green,
              ),
            ),
            buildListTile('HomePage', Icons.home, HomePage()),
            buildListTile('My Profile', Icons.person, Login('', '')),
            buildListTile('Exit', Icons.exit_to_app, SignIn())
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        child: StreamBuilder<List<Article>>(
            stream: newsBloc.newsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemBuilder: (context, indeks) {
                      var article = snapshot.data![indeks];
                      initializeDateFormatting('tr');

                      return Card(
                          child: Column(
                        children: [
                          Image.network(article.urlToImage.toString()),
                          Text(DateFormat.yMMMEd('tr_TR')
                              .format(DateTime.now())
                              .toString()),
                          ExpansionTile(
                            title: Text(article.title.toString()),
                            subtitle: Text(article.source!.name.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  addFavorite.AddFavorite(Article);
                                },
                                icon: Icon(Icons.favorite)),
                            children: [
                              ListTile(
                                title: Text(article.description.toString()),
                              )
                            ],
                          ),
                        ],
                      ));
                    },
                    itemCount: snapshot.data!.length);
              }
              return Center(child: CircularProgressIndicator());
            }),
      )),
    );
  }

  ListTile buildListTile(String yazi, IconData icon, dynamic Sayfa) {
    return ListTile(
      title: Text(yazi),
      leading: Icon(icon),
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Sayfa));
      },
    );
  }
}

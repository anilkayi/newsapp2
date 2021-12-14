// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/services/firebase_comment/add_comment.dart';
import 'package:newsapp2/services/firebase_comment/comment_models.dart';
import 'package:newsapp2/services/firebase_comment/firebase_comment.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; //
import 'package:share/share.dart';

class CommentPage extends StatefulWidget {
  String urltoImage;
  String title;
  String user_name;
  String url;

  CommentPage(this.url, this.user_name, this.urltoImage, this.title);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  AddComment _addComment = AddComment();
  TextEditingController commentController = TextEditingController();
  var refComment = FirebaseDatabase.instance.reference().child('Comment');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Share.share(widget.url);
              },
              icon: Icon(Icons.share)),
        ],
      ),
      body: SafeArea(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInImage(
            image: NetworkImage(widget.urltoImage),
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
          Text(widget.title),
          StreamBuilder<Event>(
              stream: refComment.onValue,
              builder: (context, event) {
                if (event.hasData) {
                  var commentList = <UserComment>[];
                  var getData = event.data!.snapshot.value;
                  if (getData != null) {
                    getData.forEach((key, value) {
                      var userCommentData = UserComment.fromJson(value);
                      commentList.add(userCommentData);
                    });
                    return Expanded(
                      child: ListView.builder(
                          itemCount: commentList.length,
                          itemBuilder: (context, indx) {
                            return widget.title == commentList[indx].title
                                ? Card(
                                    child: Column(
                                      children: [
                                        Text(commentList[indx].created_at),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              child: Text(commentList[indx]
                                                  .user_name[0]
                                                  .toUpperCase()),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(commentList[indx].user_name),
                                          ],
                                        ),
                                        //

                                        Text(commentList[indx].comment)
                                      ],
                                    ),
                                  )
                                : Center();
                          }),
                    );
                  }
                }
                return Center();
              }),
          TextField(
            controller: commentController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write comment...',
                suffixIcon: GestureDetector(
                  onTap: () {
                    var bytes = utf8.encode(widget.url);
                    var sha = sha1.convert(bytes);
                    sha1.convert(bytes);
                    _addComment.CommentFunc(
                        sha.toString(),
                        widget.user_name,
                        commentController.text,
                        widget.title,
                        DateTime.now().toString());
                    commentController.clear();
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                )),
          ),
        ],
      ))),
    );
  }
}

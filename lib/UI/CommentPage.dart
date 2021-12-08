import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/services/firebase_comment/add_comment.dart';
import 'package:newsapp2/services/firebase_comment/comment_models.dart';
import 'package:newsapp2/services/firebase_comment/firebase_comment.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; //

void main() {
  var bytes = utf8.encode("foobar"); // data being hashed

  var digest = sha1.convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
}

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
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(widget.urltoImage),
          Text(widget.title),
          StreamBuilder<Event>(stream: refComment.onValue
              ,builder: (context,event){
            if(event.hasData){
              var commentList = <UserComment>[];
              var getData = event.data!.snapshot.value;
if(getData != null){
  getData.forEach((key,value){
    var userCommentData = UserComment.fromJson(key, value);
    commentList.add(userCommentData);
  });
  return ListView.builder(itemCount: commentList.length,itemBuilder: (context,indx){
    return Card(

    );
  });
}

            }
              })
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
                        widget.urltoImage);
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

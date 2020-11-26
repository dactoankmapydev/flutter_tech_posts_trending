import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/models/post_repo.dart';
import 'package:flutter_tech_posts_trending/network/api.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

import 'collection.dart';

class TrendingRepos extends StatefulWidget {
  @override
  _TrendingReposState createState() => _TrendingReposState();
}

class _TrendingReposState extends State<TrendingRepos> {
  StreamController _streamController = StreamController<List<PostRepo>>();
  List<PostRepo> _listRepo = List();

  @override
  void initState() {
    super.initState();
    Api().postTrending().then((listRepos) {
      _listRepo = listRepos;
      _streamController.sink.add(listRepos);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostRepo>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListView.builder(

            itemBuilder: (context, index) {
              print(snapshot.data[index].name);
              return _buildRepo(index, snapshot.data[index]);
            },
          );
        });
  }

  Widget _buildRepo(int index, PostRepo repo) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Image.network(
                  'https://cdn.iconscout.com/icon/free/png-256/repo-5-433148.png',
                  width: 25,
                  height: 25,
                ),
              ),
              Expanded(
                child: Text(
                  repo.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 30,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              repo.tag,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    onPressed: doSignIn,
                    child: Icon(Icons.bookmark_border),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void doSignIn() async {
    var isLogged = await SPref.instance.get("token");
    if (isLogged == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CollectionPage()),
      );
      return;
    }
  }
}

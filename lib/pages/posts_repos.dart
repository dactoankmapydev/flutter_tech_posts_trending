import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/models/posts_repo.dart';
import 'package:flutter_tech_posts_trending/network/posts_api.dart';

class TrendingRepos extends StatefulWidget {
  @override
  _TrendingReposState createState() => _TrendingReposState();
}

class _TrendingReposState extends State<TrendingRepos> {
  StreamController _streamController = StreamController<List<PostsRepo>>();
  List<PostsRepo> _listRepo = List();

  @override
  void initState() {
    super.initState();
    PostsApi().postsTrending().then((listRepos) {
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
    return StreamBuilder<List<PostsRepo>>(
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
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              print(snapshot.data[index].name);
              return _buildRepo(index, snapshot.data[index]);
            },
          );
        });
  }

  Widget _buildRepo(int index, PostsRepo repo) {
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
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Text(
              repo.tags,
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
                !repo.bookmarked
                    ? GestureDetector(
                        onTap: () {
                          print("add bookmark" + repo.name);
                          PostsApi().bookmark(repo.name).then(
                            (res) {
                              _listRepo.elementAt(index).bookmarked = true;
                              _streamController.sink.add(_listRepo);
                            },
                          );
                        },
                        child: Container(
                          child: Icon(Icons.bookmark_border),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print("del bookmark" + repo.name);
                          PostsApi().delBookmark(repo.name).then(
                            (res) {
                              _listRepo.elementAt(index).bookmarked = false;
                              _streamController.sink.add(_listRepo);
                            },
                          );
                        },
                        child: Container(
                          child: Icon(Icons.bookmark),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAvatarContributors(List<String> avatars) {
    List<Widget> avatarWidgets = List();
    avatars.forEach((avatar) {
      avatarWidgets.add(
        Container(
          margin: EdgeInsets.only(right: 5),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(4),
            child: Image.network(
              avatar,
              height: 20,
              width: 20,
            ),
          ),
        ),
      );
    });
    return avatarWidgets;
  }
}

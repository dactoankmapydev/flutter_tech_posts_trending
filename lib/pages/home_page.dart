import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/pages/profile_page.dart';
import 'package:flutter_tech_posts_trending/pages/signin_page.dart';
import 'package:flutter_tech_posts_trending/pages/trending_repos.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

import 'bookmark_repos.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TrendingRepos(),
    BookmarkRepos(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          'DevReading',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await SPref.instance.set("token", null);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                      (Route<dynamic> route) => false,
                );
              })
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Bài viết'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Bộ sưu tập'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Hồ sơ của tôi'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/pages/signin_page.dart';
import 'package:flutter_tech_posts_trending/pages/signup_page.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bộ sưu tập'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Bài viết bạn đã lưu tại đây',
              style: new TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            new Text('Đăng ký hoặc đăng nhập để xem bài viết bạn lưu',
              style: new TextStyle(
                height: 2,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 550,
              height: 45,
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.blue,
                child: Text(
                  'Tạo tài khoản',
                  style: TextStyle(color: Colors.white),
                ),
                  onPressed: () async {
                    var isLogged = await SPref.instance.get("token");
                    if (isLogged == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    }
                  }
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Đã có tài khoản? Đăng nhập',
                   style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
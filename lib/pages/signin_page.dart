import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/network/posts_api.dart';
import 'package:flutter_tech_posts_trending/pages/signup_page.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal),
                ),
                suffixIcon: Icon(Icons.email),
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal),
                ),
                suffixIcon: Icon(Icons.lock),
                hintText: 'Password',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 250,
              height: 45,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: doSignIn,
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Sign up now',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void doSignIn() {
    var email = _emailController.text;
    var pass = _passController.text;

    PostsApi().signIn(email, pass).then((user) async {
      await SPref.instance.set("token", user.token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }
}

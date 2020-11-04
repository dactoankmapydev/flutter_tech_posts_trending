import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/network/posts_api.dart';
import 'package:flutter_tech_posts_trending/shared/spref.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal),
                ),
                suffixIcon: Icon(Icons.info),
                hintText: 'Full name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                onPressed: doSignUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void doSignUp() {
    var email = _emailController.text;
    var pass = _passController.text;
    var fullName = _fullNameController.text;

    PostsApi().signUp(email, pass, fullName).then((user) async {
      await SPref.instance.set("token", user.token);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }
}

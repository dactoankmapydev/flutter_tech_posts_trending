import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_posts_trending/models/user.dart';
import 'package:flutter_tech_posts_trending/network/api.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _fullNameTxtController =
  TextEditingController(text: '');
  final TextEditingController _emailTxtController =
  TextEditingController(text: '');
  final TextEditingController _passwordTxtController =
  TextEditingController(text: '');

  final StreamController _streamController = StreamController<User>();
  bool enableEditProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Api().profile().then(
          (user) {
        _streamController.sink.add(user);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          _fullNameTxtController.text = snapshot.data.full_name;
          _emailTxtController.text = snapshot.data.email;
          _passwordTxtController.text = snapshot.data.password;

          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _fullNameTxtController,
                  enabled: enableEditProfile,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                    suffixIcon: Icon(Icons.info),
                    hintText: 'Tên tài khoản',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailTxtController,
                  enabled: enableEditProfile,
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
                  controller: _passwordTxtController,
                  enabled: enableEditProfile,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                    suffixIcon: Icon(Icons.lock),
                    hintText: 'Mật khẩu',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                    onPressed: () {
                      if (enableEditProfile) {
                        // update profile
                        print(_fullNameTxtController.text);
                        // print(_emailTxtController.text);
                        print(_passwordTxtController.text);

                        Api()
                            .updateProfile(User(
                            full_name: _fullNameTxtController.text,
                            email: _emailTxtController.text,
                            password: _passwordTxtController.text))
                            .then(
                              (user) {
                            enableEditProfile = false;
                            _streamController.sink.add(user);
                          },
                        );
                      }
                      setState(() {
                        enableEditProfile = !enableEditProfile;
                      });
                    },
                    child: Text(
                      enableEditProfile ? 'Xác nhận' : 'Cập nhật tài khoản',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
class User {
  String full_name;
  String email;
  String password;
  String token;

  User({this.full_name, this.email, this.password});

  User.fromJson(Map<String, dynamic> json)
      : full_name = json['full_name'],
        email = json['email'],
        password = json['password'],
        token = json['token'];
}
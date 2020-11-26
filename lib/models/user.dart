class User {
  String fullName;
  String email;
  String password;
  String token;

  User({this.fullName, this.email, this.password});

  User.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        email = json['email'],
        password = json['password'],
        token = json['token'];
}
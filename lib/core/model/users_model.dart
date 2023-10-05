class UsersModel {
  String username;
  String title;
  String email;
  String password;
  String profileImg;
  String uid;
  List<dynamic> followers;
  List<dynamic> following;

  UsersModel({
    required this.username,
    required this.title,
    required this.email,
    required this.password,
    required this.profileImg,
    required this.uid,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': username,
      'title': title,
      'email': email,
      'password': password,
      'profileImg': profileImg,
      'uid': uid,
      'following': following,
      'followers': followers,
    };
  }

  factory UsersModel.fromMap(map) {
    return UsersModel(
      username: map['name'] as String,
      title: map['title'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profileImg: map['profileImg'] as String,
      uid: map['uid'] as String,
      following: List.from(map['following']),
      followers: List.from(map['followers']),
    );
  }
}

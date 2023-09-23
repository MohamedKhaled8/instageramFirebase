class UsersModel {
     String name;
   String title;
   String email;
   String password;
 String profileImg;
 String uid;
  UsersModel({
    required this.name,
    required this.title,
    required this.email,
    required this.password,
    required this.profileImg,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'title': title,
      'email': email,
      'password': password,
      'profileImg': profileImg,
      'uid': uid,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      name: map['name'] as String,
      title: map['title'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profileImg: map['profileImg'] as String,
      uid: map['uid'] as String,
    );
  }
}
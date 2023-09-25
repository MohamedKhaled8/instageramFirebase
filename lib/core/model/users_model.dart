class UsersModel {
  String name;
  String title;
  String email;
  String password; // Consider using a more secure way to store passwords
  String profileImg;
  String uid;
 List followers;
  List following; // Specify the type

  UsersModel({
    required this.name,
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
      'name': name,
      'title': title,
      'email': email,
      'password': password, // Consider hashing the password
      'profileImg': profileImg,
      'uid': uid,
      'following': [],
      'followers': [],
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      name: map['name'] as String,
      title: map['title'] as String,
      email: map['email'] as String,
      password: map['password'] as String, // Consider hashing the password
      profileImg: map['profileImg'] as String,
      uid: map['uid'] as String,
      following: [], // Specify the type
      followers: [], // Specify the type
    );
  }
}

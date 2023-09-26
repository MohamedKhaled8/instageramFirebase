class PostModel {
  final String profileImg;
  final String username;
  final String description;
  final String imgPost;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final List likes;
  PostModel({
    required this.profileImg,
    required this.username,
    required this.description,
    required this.imgPost,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profileImg': profileImg,
      'username': username,
      'description': description,
      'imgPost': imgPost,
      'uid': uid,
      'postId': postId,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        profileImg: map['profileImg'] as String,
        username: map['username'] as String,
        description: map['description'] as String,
        imgPost: map['imgPost'] as String,
        uid: map['uid'] as String,
        postId: map['postId'] as String,
        datePublished:
            DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
        likes: List.from(
          (map['likes'] as List),
        ));
  }
}

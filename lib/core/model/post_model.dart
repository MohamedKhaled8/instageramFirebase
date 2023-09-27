import 'package:cloud_firestore/cloud_firestore.dart';
// post_data.dart

class PostData {
  final String profileImg;
  final String username;
  final String description;
  final String imgPost;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final List likes;

  PostData({
    required this.profileImg,
    required this.username,
    required this.description,
    required this.imgPost,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.likes,
  });

  // تحويل البيانات إلى Map<String, dynamic>
  Map<String, dynamic> convert2Map() {
    return {
      "profileImg": profileImg,
      "username": username,
      "description": description,
      "imgPost": imgPost,
      "uid": uid,
      "postId": postId,
      "datePublished": datePublished.millisecondsSinceEpoch ~/ 1000, // تحويل التاريخ إلى timestamp
      "likes": likes,
    };
  }

  // تحويل DocumentSnapshot إلى كائن من نوع PostData
  static PostData convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostData(
      profileImg: snapshot["profileImg"],
      username: snapshot["username"],
      description: snapshot["description"],
      imgPost: snapshot["imgPost"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      datePublished: DateTime.fromMillisecondsSinceEpoch(snapshot["datePublished"] * 1000), // تحويل timestamp إلى DateTime
      likes: snapshot["likes"],
    );
  }
}

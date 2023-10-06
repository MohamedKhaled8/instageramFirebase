import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class ProfileController extends GetxController {
  Future<void> getData(String uiddd);
  Future<void> filterPostUser(String uiddd);
  void updateIsCurrentUser(String uid);
  Future<void> getUsers(String userName);
  Future<void> updateFollowersAndFollowing(
      String currentUserUid, String otherUserUid);
  void isBool(bool showBackButton);
  void isIncrease(bool showFollows);
  Map get userData;
  bool get isLoading;
  int get followers;
  int get following;
  List get filterPostList;
  int get postCount;
  bool get isCurrentUser;
  bool get showBackButton;
  bool get showFollow;
  List<Map<String, dynamic>> get searchResults;
  List<QueryDocumentSnapshot> get users;
  TextEditingController get myController;
  String get auth;
  FirebaseFirestore get firebaseFirestore;
}

class ProfileControllerImp extends ProfileController {
  Map _userData = {};
  bool _isLoading = true;
  int _followers = 0;
  int _following = 0;
  final List _filterPostList = [];
  int _postCount = 0;
  bool _isCurrentUser = false;
  final _showBackButton = false;
  bool _showFollow = true;

  @override
  Map get userData => _userData;

  @override
  bool get isLoading => _isLoading;

  @override
  int get followers => _followers;

  @override
  int get following => _following;

  @override
  List get filterPostList => _filterPostList;

  @override
  int get postCount => _postCount;

  @override
  bool get isCurrentUser => _isCurrentUser;

  @override
  bool get showBackButton => _showBackButton;
  @override
  bool get showFollow => _showFollow;

  @override
  List<Map<String, dynamic>> get searchResults => _searchResults;
  @override
  List<QueryDocumentSnapshot> get users => _users;
  @override
  TextEditingController get myController => _myController;
  @override
  String get auth => _auth;
  @override
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  final _searchResults = <Map<String, dynamic>>[];
  final _users = <QueryDocumentSnapshot>[];
  final TextEditingController _myController = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FireBaseServices _fireBaseServices = FireBaseServices();

  @override
  Future<void> getUsers(String userName) async {
    try {
      var query = await firebaseFirestore
          .collection('Users')
          .where("name", isEqualTo: userName)
          .get();
      users.assignAll(query.docs);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: $e");
    }
  }

  @override
  Future<void> getData(String uiddd) async {
    _isLoading = true;
    update();

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('Users').doc(uiddd).get();

      _userData = snapshot.data()!;
      _followers = userData["followers"].length;
      _following = userData["following"].length;
      _showFollow = userData["followers"].contains(auth);
      filterPostUser(uiddd);

      updateIsCurrentUser(uiddd);
    } catch (e) {
      Get.snackbar(e.toString(), "${Text(e.toString())}");
    }

    _isLoading = false;
    update();
  }

  @override
  Future<void> filterPostUser(String uiddd) async {
    try {
      final result = await _fireBaseServices.filterPostUser(uiddd);
      filterPostList.assignAll(result["filterPostList"]);
      _postCount = result["postCount"];
    } catch (e) {
      Get.snackbar(e.toString(), "${Text(e.toString())}");
    }
    update();
  }

  @override
  void updateIsCurrentUser(String uid) {
    _isCurrentUser = (uid == auth);
    update();
  }

  @override
  Future<void> updateFollowersAndFollowing(
      String currentUserUid, String otherUserUid) async {
    try {
      _fireBaseServices.updateFollowersAndFollowing(
          currentUserUid, otherUserUid, showFollow);
    } catch (e) {
      Get.snackbar("Error", "Failed to update followers and following: $e");
    }
  }

  @override
  void isBool(bool showFollows) {
    _showFollow = showFollows;
    update();
  }

  @override
  void isIncrease(bool increase) {
    if (increase) {
      _followers++;
    } else {
      _followers--;
    }
    update();
  }

  @override
  void onInit() {
    final String uiddd = auth;

    getData(uiddd);
    filterPostUser(uiddd);
    updateIsCurrentUser(uiddd);
    super.onInit();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

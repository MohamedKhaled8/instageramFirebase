import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

class UserProfile {
  Map _userData = {};
  bool _isLoading = true;
  int _followers = 0;
  int _following = 0;
  final List _filterPostList = [];
  int _postCount = 0;
  bool _isCurrentUser = false;
  final _showBackButton = false;
  bool _showFollow = true;

  final _searchResults = <Map<String, dynamic>>[];
  final _users = <QueryDocumentSnapshot>[];
  final TextEditingController _myController = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FireBaseServices _fireBaseServices = FireBaseServices();

  Map get userData => _userData;

  bool get isLoading => _isLoading;

  int get followers => _followers;

  int get following => _following;

  List get filterPostList => _filterPostList;

  int get postCount => _postCount;

  bool get isCurrentUser => _isCurrentUser;

  bool get showBackButton => _showBackButton;

  bool get showFollow => _showFollow;

  List<Map<String, dynamic>> get searchResults => _searchResults;

  List<QueryDocumentSnapshot> get users => _users;

  TextEditingController get myController => _myController;

  String get auth => _auth;

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;
}

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SearchController extends GetxController {
  void searchUsers(String userName);
  void isBoll(bool showBackButton);
}

class SearchControllerImp extends SearchController {
  bool showBackButton = false;
  var users = <QueryDocumentSnapshot>[];

  @override
  void searchUsers(String userName) async {
    var query = await FirebaseFirestore.instance
        .collection('Users')
        .where("name", isEqualTo: userName)
        .get();
    users.assignAll(query.docs);
    update();
  }

  @override
  void isBoll(bool showBackButton) {
    showBackButton = showBackButton;
    update();
  }

  @override
  void onInit() {
    searchUsers;
    super.onInit();
  }
}

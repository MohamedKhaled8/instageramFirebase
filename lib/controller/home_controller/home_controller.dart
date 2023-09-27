import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:instagramclone/core/services/fire_base_services/db/firebase_sevices.dart';

abstract class HomeController extends GetxController {
  void signOut();
}

class HomeControllerImp extends HomeController {
  final isLoading = true.obs;
  final hasError = false.obs;
  final posts = List<Map<String, dynamic>>.empty().obs;

  Future<void> fetchData() async {
    try {
      final data = await FireBaseServices().fetchDataFromFirebase();

      posts.assignAll(data);
      isLoading.value = false;
      hasError.value = false;

      update();
    } catch (error) {
      isLoading.value = false;
      hasError.value = true;

      update();
    }
  }

  @override
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData(); 
  }
}

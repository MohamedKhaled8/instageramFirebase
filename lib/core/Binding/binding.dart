import 'package:get/get.dart';
import 'package:instagramclone/controller/nav_bar_controller/nav_bar_controller.dart';
import 'package:instagramclone/controller/auth/login_controller/login_controller.dart';
import 'package:instagramclone/controller/auth/register_controller/register_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationBarControllerImp());
    Get.lazyPut(() => RegisterControllerImp());
    Get.lazyPut(() => LoginScreenControllerImp());
  }
}

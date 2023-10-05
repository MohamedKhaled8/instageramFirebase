import 'package:get/get.dart';
import 'package:instagramclone/controller/home_controller/search_controller.dart';
import 'package:instagramclone/controller/home_controller/comment_controller.dart';
import 'package:instagramclone/controller/home_controller/profile_controller.dart';
import 'package:instagramclone/controller/home_controller/add_post_controller.dart';
import 'package:instagramclone/controller/nav_bar_controller/nav_bar_controller.dart';
import 'package:instagramclone/controller/auth/login_controller/login_controller.dart';
import 'package:instagramclone/controller/auth/register_controller/register_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationBarControllerImp());
    Get.lazyPut(() => RegisterControllerImp());
    Get.lazyPut(() => LoginScreenControllerImp());
    Get.lazyPut(() => ProfileControllerImp());
    Get.lazyPut(() => AddPostControllerImp());
    Get.lazyPut(() => SearchControllerImp());
    Get.lazyPut(() => CommentControllerImp());
  }
}

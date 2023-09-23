import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class LoginScreenController extends GetxController {
  showPassword() ;
}
class LoginScreenControllerImp extends LoginScreenController {


  final TextEditingController emailLogCont = TextEditingController();
  final TextEditingController passwordLogCont = TextEditingController();
  final GlobalKey<FormState> formKeylog = GlobalKey<FormState>();
  bool isShowPassword = true;

   @override
  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  void dispose() {

   emailLogCont.dispose();
   passwordLogCont.dispose();
    super.dispose();
  }

}
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/core/constant/secure.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/auth/revist/revist_screen.dart';
import 'package:instagramclone/widgets/custom_local/custom_text_local.dart';
import 'package:instagramclone/controller/auth/login_controller/login_controller.dart';
import 'package:instagramclone/widgets/profile_widget/custom_buttom_edit_profile.dart';
import 'package:instagramclone/widgets/auth/custom_text_form_field/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginScreenControllerImp _loginScreenControllerImp =
      Get.put(LoginScreenControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: CustomTextLocal(
            text: "𝐿𝑜𝑔𝒾𝓃  ",
            color: primaryColor,
            fontSize: 35.sp,
            height: 5,
            width: 20,
            alignment: Alignment.center),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: GetBuilder<LoginScreenControllerImp>(builder: (_) {
        return Form(
          key: _loginScreenControllerImp.formKeyLog,
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Image.asset(
                "assets/png/instagram.png",
                color: primaryColor,
                height: 35.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormAuth(
                hinttext: 'Enter Your Email',
                labeltext: 'Email',
                valid: (value) {
                  if (!RegExp(validationEmail).hasMatch(value!)) {
                    return 'Invalid email';
                  } else {
                    return null;
                  }
                },
                mycontroller: _loginScreenControllerImp.emailLogCont,
                iconData: Icons.email_outlined,
                isNumber: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormAuth(
                hinttext: 'Enter Your Password',
                labeltext: 'Password',
                obscureText: _loginScreenControllerImp.isShowPassword,
                onTapIcon: () {
                  _loginScreenControllerImp.showPassword();
                },
                valid: (value) {
                  if (value.toString().length < 6) {
                    return 'Password should be longer or equal to 6 characters';
                  } else {
                    return null;
                  }
                },
                mycontroller: _loginScreenControllerImp.passwordLogCont,
                iconData: _loginScreenControllerImp.isShowPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                isNumber: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              CustomButtomLocal(
                color: Colors.grey.shade600,
                height: 45,
                width: 310,
                text: "Log in",
                fontSize: 18.sp,
                colorText: Colors.white,
                radius: 25.r,
                isIcon: false,
                onTap: () async {
                  await _loginScreenControllerImp.sendDataLoginUserToFirebase();
                },
              ),
              const RevistScreen(
                text: 'Do not have an account?',
                textButton: 'Register',
              ),
            ],
          ),
        );
      })),
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/core/constant/secure.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/widgets/auth/revist/revist_screen.dart';
import 'package:instagramclone/widgets/profile_widget/custom_buttom_edit_profile.dart';
import 'package:instagramclone/controller/auth/register_controller/register_controller.dart';
import 'package:instagramclone/widgets/auth/custom_text_form_field/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final RegisterControllerImp _registerControllerImp =
      Get.put(RegisterControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: true,
          title: Text(
            "Register Screen",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          )),
      body: SingleChildScrollView(child: GetBuilder<RegisterControllerImp>(
        builder: (_) {
          return Form(
            key: _registerControllerImp.formKeyReg,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Stack(
                  children: [
                    _registerControllerImp.imgPath == null
                        ? const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 225, 225, 225),
                            radius: 71,
                            backgroundImage:
                                AssetImage("assets/png/avatar.png"),
                          )
                        : CircleAvatar(
                            radius: 71,
                            // backgroundImage: AssetImage("assets/img/avatar.png"),
                            backgroundImage:
                                MemoryImage(_registerControllerImp.imgPath!),
                          ),
                    Positioned(
                      left: 95,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () {
                          _registerControllerImp.showmodel(context);
                        },
                        icon: const Icon(Icons.add_a_photo),
                        color: const Color.fromARGB(255, 94, 115, 128),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Your UserName',
                  labeltext: 'UserName',
                  valid: (value) {
                    if (value == null) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  mycontroller: _registerControllerImp.nameRegisterCont,
                  iconData: Icons.person,
                  isNumber: false,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Your Title',
                  labeltext: 'Title',
                  valid: (value) {
                    return null;
                  },
                  mycontroller: _registerControllerImp.titleRegisterCont,
                  iconData: Icons.title,
                  isNumber: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  mycontroller: _registerControllerImp.emailRegisterCont,
                  iconData: Icons.email_outlined,
                  isNumber: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                CustomTextFormAuth(
                  onChanged: (password) {
                    _registerControllerImp.onPasswordChanged(password);
                    _registerControllerImp.showPasswordStrength = true;
                  },
                  hinttext: 'Enter Your Password',
                  labeltext: 'Password',
                  obscureText: _registerControllerImp.isShowPassword,
                  onTapIcon: () {
                    _registerControllerImp.showPassword();
                  },
                  valid: (value) {
                    if (value.toString().length < 6) {
                      return 'Password should be longer or equal to 6 characters';
                    } else {
                      return null;
                    }
                  },
                  mycontroller: _registerControllerImp.passwordRegisterCont,
                  iconData: _registerControllerImp.isShowPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  isNumber: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Visibility(
                    visible: _registerControllerImp.showPasswordStrength,
                    child: Column(
                      children:
                          _registerControllerImp.visibilityOnPasswordChanged(),
                    ),
                  ),
                ),
                SizedBox(
                  height:
                      _registerControllerImp.showPasswordStrength ? 20.h : 0.0,
                ),
                CustomButtomLocal(
                  color: Colors.grey.shade600,
                  height: 45,
                  width: 310,
                  text: "Register",
                  fontSize: 18.sp,
                  colorText: Colors.white,
                  radius: 25.r,
                  isIcon: false,
                  onTap: () async {
                    await _registerControllerImp.sendDataUserToFirebase();
                  },
                ),
                const RevistScreen(
                  text: 'have an account?',
                  textButton: 'Log in',
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}

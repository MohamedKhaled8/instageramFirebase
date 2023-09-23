import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  void Function(String)? onChanged;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

   CustomTextFormAuth(
      {Key? key,
      this.obscureText,
      this.onTapIcon,
      this.onChanged,
      required this.hinttext,
      required this.labeltext,
      required this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber, 
      required AutovalidateMode autovalidateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20).r,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged:onChanged ,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800], // لون الخلفية في وضع الظلام
          hintText: hinttext,
          hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[400]), // لون النص التلميح في وضع الظلام
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30).r,
          labelStyle:
               const TextStyle(color: primaryColor), // لون العنوان في وضع الظلام
          labelText: labeltext,
          suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(iconData,
                  color: primaryColor)), // لون الأيقونة في وضع الظلام
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide:  const BorderSide(
                color: primaryColor), // لون حدود الإطار في وضع الظلام
          ),
        ),
      ),
    );
  }
}

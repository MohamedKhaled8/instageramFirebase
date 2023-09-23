import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridViewProfilePhoto extends StatelessWidget {
  const CustomGridViewProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10).r,
            child: Image.network(
              "https://cdn.pixabay.com/photo/2023/09/03/11/13/mountains-8230502_1280.jpg",
              fit: BoxFit.cover,
              
            ),
          );
        }));
  }
}

import 'package:flutter/material.dart';

class CustomIconsActions extends StatelessWidget {
  const CustomIconsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_outline,
              color: Colors.white,
            )),
      ],
    );
  }
}
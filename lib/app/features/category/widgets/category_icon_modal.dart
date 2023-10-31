import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconModalBottomSheet extends StatelessWidget {
  const IconModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 400,
      width: Get.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          runSpacing: 50,
          spacing: (Get.width - 48 - 180) / 4,
          children: List.generate(
            33,
            (index) => GestureDetector(
              onTap: () {
                Get.back(result: index);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/icons/$index.png',
                  width: 52,
                  height: 52,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

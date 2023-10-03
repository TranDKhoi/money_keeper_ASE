import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconModalBottomSheet extends StatelessWidget {
  const IconModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          children: List.generate(
            33,
            (index) => Container(
              margin: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  Get.back(result: index);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/icons/$index.png'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

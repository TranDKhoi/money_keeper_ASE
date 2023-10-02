import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/values/r.dart';
import '../../routes/routes.dart';

class MainAuthScreen extends StatefulWidget {
  const MainAuthScreen({Key? key}) : super(key: key);

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: [
          buildPage(
            image: "assets/images/step1.png",
            des: R.ManageyourfinanceseffectivelywithMoneyKeeper.tr,
          ),
          buildPage(
              image: "assets/images/step2.png",
              des: R.Cutunnecessaryexpenses.tr),
          buildPage(
              image: "assets/images/step3.png",
              des: R.Increasesavingssteadilyeverymonth.tr),
          buildPage(
              image: "assets/images/step4.png",
              des: R.Manageitallinoneplace.tr),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: 80,
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.green,
                    dotWidth: 28,
                    dotHeight: 13,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(signUpScreenRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(R.SIGNUPFORFREE.tr),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(loginScreenRoute);
              },
              child: Text(
                R.SIGNIN.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

buildPage({required image, required des}) {
  return Column(
    children: [
      const SizedBox(height: 180),
      Image.asset(image),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          des,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

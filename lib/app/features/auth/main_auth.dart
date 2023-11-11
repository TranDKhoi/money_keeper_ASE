import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/color.dart';
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
  
  final List<String> description = [
    R.ManageyourfinanceseffectivelywithMoneyKeeper.tr,
    R.Cutunnecessaryexpenses.tr,
    R.Increasesavingssteadilyeverymonth.tr,
    R.Manageitallinoneplace.tr
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                Image.asset("assets/icons/ic_wallet.png"),
                const SizedBox(height: 15),
                const Text(
                  "MONEY KEEPER",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  buildPage(
                    image: "assets/images/step1.png",
                    description: description[0],
                    controller: controller,
                  ),
                  buildPage(
                    image: "assets/images/step2.png",
                    description: description[1],
                    controller: controller,
                  ),
                  buildPage(
                    image: "assets/images/step3.png",
                    description: description[2],
                    controller: controller,
                  ),
                  buildPage(
                    image: "assets/images/step4.png",
                    description: description[3],
                    controller: controller,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: const JumpingDotEffect(
                dotColor: Colors.grey,
                activeDotColor: AppColors.primaryColor,
                dotWidth: 6,
                dotHeight: 6,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(signUpScreenRoute),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                    ),
                    child: Text(
                      R.SIGNUPFORFREE.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Get.toNamed(loginScreenRoute),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        
                      ),
                    ),
                    child: Text(
                      R.Signin.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  buildPage({required image, required description, required controller}) {
  return Column(
    children: [
        SizedBox(
          height: 300,
          child: Image.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          description,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        
    ],
  );
}
}



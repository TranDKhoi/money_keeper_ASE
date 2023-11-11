import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/common/primary_button.dart';
import 'package:money_keeper/app/core/values/color.dart';

import '../../../core/values/r.dart';
import '../../../routes/routes.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
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
            const SizedBox(height: 23),
            Text(
              R.Signin.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller.emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: R.Email.tr,
                  fillColor: AppColors.textFieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBg,
                    ),
                  )
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: _controller.passTextController,
                keyboardType: TextInputType.emailAddress,
                obscureText: _controller.isSecureText.value,
                decoration: InputDecoration(
                  labelText: R.Password.tr,
                  fillColor: AppColors.textFieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBg,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _controller.changeSecureText,
                    child: Obx(
                      () => Icon(
                        _controller.isSecureText.value ? Ionicons.eye : Ionicons.eye_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.toNamed(forgotPassRoute),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  R.Forgotpassword.tr,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButton(
                      title: R.Signin.tr,
                      onPressed: () => _controller.loginFunc()),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't you have account? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

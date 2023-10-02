import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../controllers/auth/login_controller.dart';
import '../../../core/values/r.dart';
import '../../../routes/routes.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              R.Signin.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller.emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: R.Email.tr,
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: _controller.passTextController,
                keyboardType: TextInputType.emailAddress,
                obscureText: _controller.isSecureText.value,
                decoration: InputDecoration(
                  hintText: R.Password.tr,
                  suffixIcon: GestureDetector(
                    onTap: _controller.changeSecureText,
                    child: Obx(
                      () => Icon(
                        _controller.isSecureText.value
                            ? Ionicons.eye
                            : Ionicons.eye_off,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.loginFunc();
              },
              child: Text(R.SIGNIN.tr),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(forgotPassRoute);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(R.Forgotpassword.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

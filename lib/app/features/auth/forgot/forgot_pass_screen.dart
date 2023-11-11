import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/features/auth/controller/forgot_controller.dart';

import '../../../core/values/r.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _controller = Get.put(ForgotPassController());

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
            Image.asset(
              "assets/icons/ic_wallet.png",
              height: 50,
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "MONEY KEEPER",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              R.Entertheemailaccountthatyouwanttorecovery.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
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
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _controller.toVerifyScreen(),
              child: Text(R.SENDCODE.tr),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

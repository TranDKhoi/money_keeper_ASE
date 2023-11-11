import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/common/primary_button.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/features/auth/controller/forgot_controller.dart';

import '../../../core/values/r.dart';

class VerifyForgotScreen extends StatefulWidget {
  const VerifyForgotScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgotScreen> createState() => _VerifyForgotScreenState();
}

class _VerifyForgotScreenState extends State<VerifyForgotScreen> {
  // final ForgotPassController _controller = Get.find();
  final ForgotPassController _controller = Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              R.A4charactercodehasbeensenttotheemail.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: VerificationCode(
                digitsOnly: true,
                fullBorder: true,
                itemSize: context.screenSize.width / 8,
                underlineColor: Colors.grey,
                keyboardType: TextInputType.number,
                length: 4,
                onCompleted: (String value) {
                  setState(() {
                    _controller.secureCode = value;
                  });
                },
                onEditing: (bool value) {
                  if (!value) FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PrimaryButton(
                  title: R.CONFIRM.tr,
                  onPressed: () => _controller.verifyCodeFunc()),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.back(),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  R.Didntreceiveanycode.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

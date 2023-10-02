import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../controllers/auth/singnup_controller.dart';
import '../../../core/values/r.dart';

class VerifySignupScreen extends StatefulWidget {
  const VerifySignupScreen({Key? key}) : super(key: key);

  @override
  State<VerifySignupScreen> createState() => _VerifySignupScreenState();
}

class _VerifySignupScreenState extends State<VerifySignupScreen> {
  final SignupController _controller = Get.find();

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
              "${R.A4charactercodehasbeensenttotheemail.tr} ${_controller.emailTextController.text}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.verifyCodeFunc();
              },
              child: Text(R.VERIFY.tr),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(R.Didntreceiveanycode.tr),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

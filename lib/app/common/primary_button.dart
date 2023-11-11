import 'package:flutter/material.dart';
import 'package:money_keeper/app/core/values/color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

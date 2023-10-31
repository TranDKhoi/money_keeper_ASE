import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';

class MoneyField extends StatelessWidget {
  const MoneyField({Key? key, required this.controller, this.hintText}) : super(key: key);

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppStyles.text14Normal.copyWith(color: AppColors.primaryColor),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(locale: 'vi', decimalDigits: 0, symbol: "đ"),
      ],
      decoration: InputDecoration(
        hintText: hintText ?? "VND",
        fillColor: Colors.transparent,
        suffixIcon: const Icon(Ionicons.create_outline),
      ),
    );
  }
}

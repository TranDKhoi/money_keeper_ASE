import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyField extends StatelessWidget {
  const MoneyField({Key? key, required this.controller,this.hintText})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 30,
        color: Colors.green,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(locale: 'vi', decimalDigits: 0, symbol: "đ"),
      ],
      decoration: InputDecoration(
        hintText: hintText ?? "VND",
        hintStyle: const TextStyle(
          color: Colors.green,
        ),
        fillColor: Colors.transparent,
      ),
    );
  }
}

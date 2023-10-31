import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';

import '../../../data/models/transaction.dart';
import '../../core/utils/utils.dart';
import '../../features/transaction/edit_transaction.dart';

class HomeTransactionItem extends StatelessWidget {
  const HomeTransactionItem({Key? key, required this.transaction}) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: ListTile(
        onTap: () => Get.to(() => EditTransactionScreen(selectedTrans: transaction)),
        leading: Image.asset("assets/icons/${transaction.category?.icon ?? 1}.png"),
        title: Text(
          transaction.category?.name ?? "Unnamed",
          style: AppStyles.text16Bold,
        ),
        subtitle: Text(
          FormatHelper().dateFormat(transaction.createdAt ?? DateTime.now()),
          style: AppStyles.text14Normal,
        ),
        trailing: Text(
          FormatHelper().moneyFormat(transaction.amount?.toDouble()),
          style: TextStyle(
            color: transaction.category?.type == "Income"
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

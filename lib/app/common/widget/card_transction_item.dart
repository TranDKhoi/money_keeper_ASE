import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/transactions_by_day.dart';
import '../../core/values/r.dart';
import '../../modules/transaction/edit_transaction.dart';
import 'note_transaction_item.dart';

class CardTransactionItem extends StatelessWidget {
  const CardTransactionItem({Key? key, required this.transactionsByDay})
      : super(key: key);

  final TransactionsByDay transactionsByDay;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              isThreeLine: true,
              leading: Text(
                transactionsByDay.date?.day.toString() ?? "null",
                style: const TextStyle(fontSize: 30),
              ),
              title: transactionsByDay.date?.day == DateTime.now().day
                  ? Text(R.Today.tr)
                  : Text(DateFormat('EEEE').format(transactionsByDay.date!).tr),
              subtitle:
                  Text(FormatHelper().dateFormat(transactionsByDay.date!)),
              trailing: Text(
                FormatHelper().moneyFormat(transactionsByDay.revenue?.toDouble()),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ...?transactionsByDay.transactions
                ?.map((e) => NoteTransactionItem(
                      onTap: () => Get.to(() => EditTransactionScreen(
                            selectedTrans: e,
                          )),
                      transaction: e,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}

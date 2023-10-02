import 'package:flutter/material.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/transaction.dart';

class NoteTransactionItem extends StatelessWidget {
  const NoteTransactionItem(
      {Key? key, required this.onTap, required this.transaction})
      : super(key: key);

  final Transaction transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      dense: true,
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/icons/${transaction.category?.icon!}.png"),
      ),
      title: Text(
        transaction.category?.name ?? "Untitled category",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        transaction.note ?? "empty note",
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: Text(
        FormatHelper().moneyFormat(transaction.amount?.toDouble()),
        style: TextStyle(
          color: transaction.category?.type == "Expense"
              ? Colors.redAccent
              : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

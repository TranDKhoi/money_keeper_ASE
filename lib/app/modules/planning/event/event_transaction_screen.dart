import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/common/widget/card_transction_item.dart';
import 'package:money_keeper/data/models/transactions_by_time.dart';

import '../../../../data/models/event.dart';
import '../../../../data/services/transaction_service.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/r.dart';

class EventTransactionScreen extends StatefulWidget {
  const EventTransactionScreen({Key? key}) : super(key: key);

  @override
  State<EventTransactionScreen> createState() => _EventTransactionScreenState();
}

class _EventTransactionScreenState extends State<EventTransactionScreen> {
  final Event selectedEvent = Get.arguments[0] as Event;
  final int walletId = Get.arguments[1] as int;

  TransactionsByTime listTransactionByTime = TransactionsByTime();

  @override
  void initState() {
    _getListTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Listoftransaction.tr),
      ),
      body: Column(
        children: [
          //summary information here
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //number of result
                  Text(
                    "${_getTotalTransaction()} ${R.result.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //income
                  Row(
                    children: [
                      Text(
                        R.Income.tr,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(_calculateIncome().toDouble()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  //expense
                  Row(
                    children: [
                      Text(
                        R.Expense.tr,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(_calculateExpense().toDouble()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(
                            (_calculateIncome() - _calculateExpense()).toDouble()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //list of transaction
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => CardTransactionItem(
                transactionsByDay: listTransactionByTime.details![i],
              ),
              itemCount: listTransactionByTime.details?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  int _calculateIncome() {
    return listTransactionByTime.totalIncome ?? 0;
  }

  int _calculateExpense() {
    return listTransactionByTime.totalExpense ?? 0;
  }

  Future<void> _getListTransaction() async {
    var res = await TransactionService.ins
        .getTransactionOfEvent(walletId, selectedEvent.id!);

    if (res.isOk) {
      setState(() {
        listTransactionByTime = TransactionsByTime.fromJson(res.data);
      });
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  _getTotalTransaction() {
    if (listTransactionByTime.details?.isEmpty ?? true) {
      return 0;
    }
    int total = 0;
    for (int i = 0; i < listTransactionByTime.details!.length; i++) {
      final detailAtI = listTransactionByTime.details![i];
      for (int j = 0; j < detailAtI.transactions!.length; j++) {
        total++;
      }
    }
    return total;
  }
}

import 'package:flutter/material.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/pie_report.dart';

class InExItem extends StatelessWidget {
  const InExItem(this.e, {Key? key}) : super(key: key);
  final PieReport e;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          "assets/icons/${e.category.icon}.png",
        ),
      ),
      title: Text(e.category.name ?? ""),
      trailing: Text(FormatHelper().moneyFormat(e.amount.toDouble())),
    );
  }
}

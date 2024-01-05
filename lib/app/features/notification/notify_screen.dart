import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/features/invitation/manage_invitation_screen.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/models/notify.dart';

import '../../../data/services/notify_service.dart';
import '../../core/values/r.dart';
import '../planning/controller/budget/budget_controller.dart';
import 'controller/notification_controller.dart';

class NotifyScreen extends StatelessWidget {
  NotifyScreen({Key? key}) : super(key: key);
  final _controller = Get.find<NotificationController>()..getAllNotify();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Notification.tr),
        actions: [
          TextButton(
            onPressed: () => _controller.seenAllNotify(),
            child: Text(R.Seenall.tr),
          )
        ],
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, i) => _buildNotiItem(_controller.listNotify[i]),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _controller.listNotify.length,
        ),
      ),
    );
  }

  _buildNotiItem(Notify notify) {
    String icon = "";
    switch (notify.type) {
      case "BudgetExceed":
        icon = "assets/icons/warning.png";
        break;
      case "Reminder":
        icon = "assets/icons/alarm.png";
        break;
      case "JoinWalletInvitation":
        icon = "assets/icons/invite.png";
        break;
    }

    return ListTile(
      onTap: () async {
        NotifyService.ins.seenById(id: notify.id!);
        switch (notify.type) {
          case "BudgetExceed":
            await Get.put(BudgetController())
                .initBudgetInfoScreenData(budgetId: notify.budgetId as int);
            await Get.toNamed(budgetInfoScreen);
            break;
          case "Reminder":
            icon = "assets/icons/alarm.png";
            break;
          case "JoinWalletInvitation":
            Get.to(() => ManageInvitationScreen());
            icon = "assets/icons/invite.png";
            break;
        }
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(icon),
      ),
      title: Row(
        children: [
          Expanded(
              flex: 20,
              child: Text(
                notify.description ?? "",
                maxLines: 3,
              )),
          const Spacer(),
          Visibility(
            visible: !(notify.isSeen ?? false),
            child: const Expanded(
              flex: 1,
              child: Icon(
                Icons.circle,
                size: 15,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          const Spacer(),
          Text(FormatHelper().getTimeAgo(notify.createdAt) ?? ""),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/features/my_wallet/controller/my_wallet_controller.dart';
import 'package:money_keeper/data/models/wallet.dart';

import '../../core/utils/utils.dart';
import '../../core/values/r.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final _controller = Get.find<MyWalletController>();

  final bool isFromTransactionScreen = Get.arguments ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              R.Mywallet.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Obx(
              () => Text(
                _controller.calculateTotalBalance(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _controller.getAllWallet();
              setState(() {});
            },
            icon: const Icon(Ionicons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: context.screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                child: ExpansionTile(
                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: Image.asset(
                        "assets/icons/ic_user.png",
                        width: 28,
                        height: 28,
                      ),
                    ),
                    title: Text(
                      R.Personal.tr,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  children: [
                    Obx(
                      () => Column(
                        children: _controller.listWallet
                            .map((element) => _buildWalletItem(element))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                child: ExpansionTile(
                  title: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: Image.asset(
                        "assets/icons/ic_group.png",
                        width: 28,
                        height: 28,
                      ),
                    ),
                    title: Text(
                      R.Group.tr,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  children: [
                    Obx(
                          () => Column(
                            children: _controller.listGroupWallet
                                .map((element) => _buildWalletItem(element))
                                .toList(),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.toAddWallet();
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildWalletItem(Wallet listWallet) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(18)
        ),
        child: ListTile(
          onTap: () {
            if (isFromTransactionScreen) {
              Get.back(result: listWallet);
            } else {
              _controller.toEditWallet(listWallet);
            }
          },
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(18)
          ),
          tileColor: const Color(0xffF7FAFC),
          isThreeLine: true,
          dense: true,
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 10),
            child: Image.asset(
              "assets/icons/${listWallet.icon}.png",
            ),
          ),
          title: Text(
            listWallet.name!,
            style: const TextStyle(fontSize: 25),
          ),
          subtitle: Text(
            FormatHelper().moneyFormat(listWallet.balance?.toDouble()),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

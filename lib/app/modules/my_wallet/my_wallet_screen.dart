import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';
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
        title: Text(R.Mywallet.tr),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: context.screenSize.height,
          child: Column(
            children: [
              const Divider(thickness: 1),
              ListTile(
                isThreeLine: true,
                dense: true,
                leading: const Icon(
                  Ionicons.earth,
                  size: 40,
                ),
                title: Text(
                  R.All.tr,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                subtitle: Obx(
                  () => Text(
                    _controller.calculateTotalBalance(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    R.Personal.tr,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Column(
                  children: _controller.listWallet
                      .map((element) => _buildWalletItem(element))
                      .toList(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    R.Group.tr,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
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
    return ListTile(
      onTap: () {
        if (isFromTransactionScreen) {
          Get.back(result: listWallet);
        } else {
          _controller.toEditWallet(listWallet);
        }
      },
      isThreeLine: true,
      dense: true,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/icons/${listWallet.icon}.png"),
      ),
      title: Text(
        listWallet.name!,
        style: const TextStyle(fontSize: 25),
      ),
      subtitle: Text(
        FormatHelper().moneyFormat(listWallet.balance?.toDouble()),
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

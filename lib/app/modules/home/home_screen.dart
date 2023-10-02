import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/bottombar_controller.dart';
import 'package:money_keeper/app/controllers/home_controller.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';
import 'package:money_keeper/app/modules/home/widgets/home_chart_bar.dart';

import '../../common/widget/home_transaction_item.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../notification/notify_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController())
    ..getSummaryData()
    ..getRecentTransaction();
  final BottomBarController _bottomController = Get.find();
  final _walletController = Get.find<MyWalletController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () async {
              return _controller.getRecentTransaction();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //total balance
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              _walletController.calculateTotalBalance(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                          Text(R.Totalbalance.tr),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.to(() => NotifyScreen()),
                        child: const Icon(Ionicons.notifications),
                      )
                    ],
                  ),
                  // my wallets
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                R.Mywallet.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _controller.toAllWalletScreen();
                                },
                                child: Text(
                                  R.Seemore.tr,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Ionicons.earth),
                              const SizedBox(width: 10),
                              Text(
                                R.All.tr,
                                style: const TextStyle(fontSize: 25),
                              ),
                              const Spacer(),
                              Obx(
                                () => Text(
                                  _walletController.calculateTotalBalance(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //report
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        R.Report.tr,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _bottomController.changePage(2);
                        },
                        child: Text(
                          R.Detail.tr,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  //week-month
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(
                                  () => Expanded(
                                    child: GestureDetector(
                                      onTap: _controller.changeSelectedReport,
                                      child: Card(
                                        elevation: 0,
                                        color:
                                            _controller.selectedReport.value ==
                                                    0
                                                ? Colors.grey[100]
                                                : Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            R.Week.tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Expanded(
                                    child: GestureDetector(
                                      onTap: _controller.changeSelectedReport,
                                      child: Card(
                                        elevation: 0,
                                        color:
                                            _controller.selectedReport.value ==
                                                    0
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Colors.grey[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            R.Month.tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //total spent
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      FormatHelper().moneyFormat(_controller
                                          .barChartData[1]
                                          .toDouble()),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      _controller.selectedReport.value == 0
                                          ? R.Totalexpenseofthisweek.tr
                                          : R.Totalexpenseofthismonth.tr,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () async {
                                    EasyLoading.show();
                                    await _controller.getSummaryData();
                                    EasyLoading.dismiss();
                                  },
                                  child: const Icon(Ionicons.refresh_outline))
                            ],
                          ),
                          //charts
                          const SizedBox(height: 30),
                          Obx(() => HomeChartBar(_controller.barChartData[0],
                              _controller.barChartData[1])),
                          //most spent
                          const SizedBox(height: 10),
                          // Text(
                          //   R.Mostexpense.tr,
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          // ListTile(
                          //   onTap: () {},
                          //   contentPadding: EdgeInsets.zero,
                          //   isThreeLine: true,
                          //   dense: true,
                          //   leading: const Icon(Ionicons.wallet),
                          //   title: const Text(
                          //     "Ăn và ún",
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //     ),
                          //   ),
                          //   subtitle: const Text(
                          //     "100.000 đ",
                          //     style: TextStyle(
                          //       fontSize: 15,
                          //     ),
                          //   ),
                          //   trailing: const Text(
                          //     "100%",
                          //     style: TextStyle(
                          //       color: Colors.redAccent,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  //recent spent
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        R.Recently.tr,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _bottomController.changePage(1);
                        },
                        child: Text(
                          R.Detail.tr,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Obx(
                        () => Column(
                          children: _controller.transactions
                              .map((element) =>
                                  HomeTransactionItem(transaction: element))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

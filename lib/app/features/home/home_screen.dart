import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';
import 'package:money_keeper/app/features/bottom_bar/controller/bottombar_controller.dart';
import 'package:money_keeper/app/features/home/controller/home_controller.dart';
import 'package:money_keeper/app/features/home/widgets/home_chart_bar.dart';
import 'package:money_keeper/app/features/my_wallet/controller/my_wallet_controller.dart';

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
  final _controller = Get.put(HomeController());
  final BottomBarController _bottomController = Get.find();
  final _walletController = Get.find<MyWalletController>();

  @override
  void initState() {
    _controller.getSummaryData();
    _controller.getRecentTransaction();
    super.initState();
  }

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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///total balance
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              _walletController.calculateTotalBalance(),
                              style: AppStyles.text28Bold,
                            ),
                          ),
                          Text(R.Totalbalance.tr, style: AppStyles.text14Normal),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.to(() => NotifyScreen()),
                        child: Image.asset(
                          "assets/icons/ic_notify.png",
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ],
                  ),

                  /// my wallets
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                R.Mywallet.tr,
                                style: AppStyles.text14Normal,
                              ),
                              Obx(
                                () => Text(
                                  _walletController.calculateTotalBalance(),
                                  style: AppStyles.text28Bold.copyWith(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _controller.toAllWalletScreen(),
                                child: Text(R.Seemore.tr),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -30,
                          right: -15,
                          child: Image.asset(
                            "assets/images/img_cash.png",
                            width: Get.width / 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///report
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text(
                        R.Report.tr,
                        style: AppStyles.text14Normal,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _bottomController.changePage(2),
                        child: Text(R.Detail.tr),
                      ),
                    ],
                  ),

                  ///week-month
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ///switch button
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
                                        color: _controller.selectedReport.value == 0
                                            ? AppColors.primaryColorVariant
                                            : Theme.of(context).scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            R.Week.tr,
                                            textAlign: TextAlign.center,
                                            style: AppStyles.text16Normal,
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
                                        color: _controller.selectedReport.value == 0
                                            ? Theme.of(context).scaffoldBackgroundColor
                                            : AppColors.primaryColorVariant,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            R.Month.tr,
                                            textAlign: TextAlign.center,
                                            style: AppStyles.text16Normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///total spent
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      FormatHelper()
                                          .moneyFormat(_controller.barChartData[1].toDouble()),
                                      style: AppStyles.text28Bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      EasyLoading.show();
                                      await _controller.getSummaryData();
                                      EasyLoading.dismiss();
                                    },
                                    child: const Icon(Ionicons.refresh_outline),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Text(
                                  _controller.selectedReport.value == 0
                                      ? R.Totalexpenseofthisweek.tr
                                      : R.Totalexpenseofthismonth.tr,
                                  style: AppStyles.text14Normal,
                                ),
                              ),
                            ],
                          ),

                          ///charts
                          const SizedBox(height: 30),
                          Obx(
                            () => HomeChartBar(
                              _controller.barChartData[0],
                              _controller.barChartData[1],
                            ),
                          ),

                          ///most spent
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

                  ///recent spent
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        R.Recently.tr,
                        style: AppStyles.text14Normal,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _bottomController.changePage(1),
                        child: Text(R.Detail.tr),
                      )
                    ],
                  ),
                  Obx(
                    () => Column(
                      children: _controller.transactions
                          .map((element) => HomeTransactionItem(transaction: element))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

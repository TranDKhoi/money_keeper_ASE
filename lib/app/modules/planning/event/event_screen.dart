import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/models/event.dart';

import '../../../../data/models/wallet.dart';
import '../../../controllers/planning/event/event_controller.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/r.dart';

class EventScreen extends StatefulWidget {
  const EventScreen(
      {Key? key, this.canChangeWallet = true, this.selectedWallet})
      : super(key: key);

  final bool canChangeWallet;
  final Wallet? selectedWallet;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(EventController());

  late TabController _tabController;

  @override
  void initState() {
    if (widget.selectedWallet != null) {
      _controller.selectedWallet.value = widget.selectedWallet!;
    }
    _controller.getAllEvent();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeEventTabBar(_tabController.index);
      }
    });
    _tabController.index = 0;
    _controller.changeEventTabBar(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(R.Event.tr),
        actions: [
          Visibility(
            visible: widget.selectedWallet == null,
            child: Obx(
              () => DropdownButton<Wallet>(
                value: _controller.selectedWallet.value,
                icon: const Icon(Ionicons.caret_down),
                onChanged: (Wallet? value) {
                  _controller.changeWallet(value!);
                },
                items: _controller.listWallet.map((Wallet value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value.name!),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(R.Running.tr),
              ),
              Visibility(
                visible: widget.selectedWallet == null ? true : false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(R.Finished.tr),
                ),
              )
            ]),
      ),
      //////////////
      body: Obx(() {
        if (_controller.listEvent.isEmpty) {
          return Center(
            child: Text(
              R.Therearecurrentlynoevents.tr,
              style: const TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) =>
                _buildEventItem(_controller.listEvent[index]),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: _controller.listEvent.length,
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(addEventScreenRoute),
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildEventItem(Event e) {
    return Card(
      child: InkWell(
        onTap: () {
          if (widget.selectedWallet == null) {
            Get.toNamed(eventInfoScreenRoute, arguments: e)?.then(
                (value) => _controller.changeEventTabBar(_tabController.index));
          } else {
            Get.back(result: e);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/icons/${e.icon}.png"),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        e.spentAmount! <= 0? "${R.Spent.tr}: ":"${R.Earned.tr}: ",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        FormatHelper().moneyFormat(e.spentAmount!.abs().toDouble()),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

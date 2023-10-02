import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/event.dart';
import '../../../controllers/planning/event/event_controller.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/r.dart';
import '../../../routes/routes.dart';

class EventInfoScreen extends StatefulWidget {
  const EventInfoScreen({Key? key}) : super(key: key);

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  final selectedEvent = Get.arguments as Event;

  final _controller = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              GestureDetector(
                  onTap: () => Get.toNamed(addEventScreenRoute,
                      arguments: selectedEvent),
                  child: const Icon(Ionicons.pencil)),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () async{
                  var res = await showDialog(
                    context: context,
                    builder: (_) => Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(R.Deletethisevent.tr),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                      onPressed: () => Get.back(result: false),
                                      child: Text(R.No.tr)),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      onPressed: () => Get.back(result: true),
                                      child: Text(R.Yes.tr)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                  if (res != null && res) {
                    _controller.deleteEvent(selectedEvent.id);
                  }
                },
                child: const Icon(Ionicons.trash),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      //////////
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //name and icon
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/icons/${selectedEvent.icon}.png"),
                ),
                const SizedBox(width: 10),
                Text(
                  selectedEvent.name!,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //end date
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  Ionicons.calendar_outline,
                ),
                const SizedBox(width: 30),
                Text(
                  "${R.Enddate.tr}: ",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  FormatHelper().dateFormat(selectedEvent.endDate!),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            const SizedBox(height: 20),
            //wallet
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/icons/${selectedEvent.icon}.png"),
                ),
                const SizedBox(width: 15),
                Text(
                  selectedEvent.wallet!.name!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.toggleEvent(selectedEvent.id),
                  child: Text(selectedEvent.isFinished!
                      ? R.Markasunfinished.tr
                      : R.Markasfinished.tr),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () => Get.toNamed(eventTransactionScreenRoute,
                        arguments: [selectedEvent,_controller.selectedWallet.value.id]),
                    child: Text(R.Listoftransaction.tr)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

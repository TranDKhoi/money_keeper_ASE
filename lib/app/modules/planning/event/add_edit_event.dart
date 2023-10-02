import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/event.dart';
import '../../../controllers/planning/event/add_edit_event_controller.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/r.dart';
import '../../../routes/routes.dart';
import '../../category/widgets/category_icon_modal.dart';

class AddEditEventScreen extends StatelessWidget {
  AddEditEventScreen({Key? key}) : super(key: key);

  final _controller = Get.put(AddEditEventController());
  final Event? selectedEvent = Get.arguments as Event?;

  @override
  Widget build(BuildContext context) {
    if (selectedEvent != null) {
      _controller.setSelectedEditEvent(selectedEvent!);
      _controller.applyData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEvent == null ? R.Addevent.tr : R.Editevent.tr),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedEvent == null) {
                _controller.createNewEvent();
              } else {
                _controller.editEvent();
              }
            },
            child: Text(R.Save.tr),
          ),
        ],
      ),
      /////
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //event name
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      var res = await showModalBottomSheet<int>(
                          context: context,
                          builder: (BuildContext context) =>
                              const IconModalBottomSheet());

                      if (res != null) {
                        _controller.selectedIcon.value = res;
                      }
                    },
                    child: Obx(
                      () {
                        if (_controller.selectedIcon.value != null) {
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                                "assets/icons/${_controller.selectedIcon.value!}.png"),
                          );
                        } else {
                          return const CircleAvatar(
                            backgroundColor: Colors.grey,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _controller.eventName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: R.Eventname.tr,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //end date
              Row(
                children: [
                  const SizedBox(width: 5),
                  const Icon(Ionicons.calendar_outline),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030));
                      if (selectedDate != null) {
                        _controller.endDate.value = selectedDate;
                      }
                    },
                    child: Obx(() {
                      if (_controller.endDate.value == null) {
                        return Text(
                          R.Enddate.tr,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        );
                      }
                      return Text(
                        FormatHelper().dateFormat(_controller.endDate.value!),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //wallet
              Row(
                children: [
                  Obx(
                    () => _controller.selectedWallet.value == null
                        ? const CircleAvatar(
                            backgroundColor: Colors.grey,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                                "assets/icons/${_controller.selectedWallet.value!.icon!}.png"),
                          ),
                  ),
                  const SizedBox(width: 30),
                  Obx(
                    () => Expanded(
                      child: TextField(
                        enabled: selectedEvent == null ? true : false,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          var res =
                              await Get.toNamed(myWalletRoute, arguments: true);
                          if (res != null) {
                            _controller.selectedWallet.value = res;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Ionicons.chevron_down),
                          contentPadding: const EdgeInsets.only(top: 20),
                          hintText:
                              _controller.selectedWallet.value?.name == null
                                  ? R.Selectwallet.tr
                                  : _controller.selectedWallet.value!.name,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
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

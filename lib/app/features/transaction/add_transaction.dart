import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/common/widget/money_field.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';
import 'package:money_keeper/app/features/planning/event/event_screen.dart';
import 'package:money_keeper/app/features/transaction/controller/add_transaction_controller.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../data/models/user.dart';
import '../../common/widget/inkwell_wrapper.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../account/controller/account_controller.dart';
import '../category/manage_category.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _controller = Get.put(AddTransactionController());
  final AccountController _ac = Get.find();
  List<User> user = [];
  var tapPosition = const Offset(0.0, 0.0);

  @override
  void initState() {
    _controller.listUserGroup.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          R.Newtransaction.tr,
          style: AppStyles.text24Bold,
        ),
        actions: [
          TextButton(
            onPressed: () => _controller.createNewTransaction(),
            child: Text(R.Save.tr),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    MoneyField(controller: _controller.amountController),
                    const SizedBox(height: 20),

                    ///wallet
                    Row(
                      children: [
                        Obx(
                          () {
                            if (_controller.selectedWallet.value != null) {
                              return CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${_controller.selectedWallet.value?.icon}.png"),
                              );
                            }
                            return const CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.hintColor,
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Expanded(
                            child: TextField(
                              enabled: true,
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                var res = await Get.toNamed(myWalletRoute, arguments: true);
                                if (res != null) {
                                  _controller.listUserGroup.clear();
                                  user.clear();
                                  _controller.selectedWallet.value = res;
                                  if (_controller.selectedWallet.value!.type == 'Group') {
                                    _controller.selectedWallet.value?.walletMembers
                                        ?.forEach((element) {
                                      if (element.user!.email != _ac.currentUser.value!.email) {
                                        user.add(element.user!);
                                      }
                                    });
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Ionicons.caret_down),
                                contentPadding: const EdgeInsets.only(top: 20),
                                hintText: _controller.selectedWallet.value?.name == null
                                    ? R.Selectwallet.tr
                                    : _controller.selectedWallet.value!.name,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    ///category
                    Row(
                      children: [
                        Obx(
                          () {
                            if (_controller.selectedCategory.value != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: Image.asset(
                                    "assets/icons/${_controller.selectedCategory.value!.icon}.png"),
                              );
                            } else {
                              return const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.hintColor,
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Obx(
                          () => Expanded(
                            child: TextField(
                              enabled: _controller.selectedWallet.value != null ? true : false,
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                var res = await Get.to(
                                  ManageCategoryScreen(
                                    canChangeWallet: false,
                                    selectedWallet: _controller.selectedWallet.value,
                                  ),
                                );
                                if (res != null) {
                                  _controller.selectedCategory.value = res;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Ionicons.caret_down),
                                contentPadding: const EdgeInsets.only(top: 20),
                                hintText: _controller.selectedCategory.value?.name == null
                                    ? R.Selectcategory.tr
                                    : _controller.selectedCategory.value!.name,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    ///note
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_note.png",
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: _controller.noteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 10),
                              hintText: R.Note.tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _controller.selectedWallet.value?.type == 'Group',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                size: 35,
                              ),
                              const SizedBox(width: 30),
                              Visibility(
                                visible: _controller.listUserGroup.isEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(R.WithMember.tr, style: AppStyles.text14Normal),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 5,
                                  children:
                                      List.generate(_controller.listUserGroup.length + 1, (index) {
                                    if (index == _controller.listUserGroup.length) {
                                      return InkWellWrapper(
                                        onTapDown: (details) {
                                          tapPosition = details.globalPosition;
                                        },
                                        onTap: () {
                                          final RenderBox overlay = Overlay.of(context)
                                              .context
                                              .findRenderObject() as RenderBox;
                                          showMenu(
                                            context: context,
                                            position: RelativeRect.fromRect(
                                                tapPosition & const Size(40, 40),
                                                // smaller rect, the touch area
                                                Offset.zero &
                                                    overlay.size // Bigger rect, the entire screen
                                                ),
                                            items: List.generate(user.length, (index) {
                                              return PopupMenuItem(
                                                value: index,
                                                onTap: () {
                                                  if (!_controller.listUserGroup
                                                      .contains(user[index])) {
                                                    _controller.listUserGroup.add(user[index]);
                                                  }
                                                },
                                                child: Text(user[index].email!),
                                              );
                                            }),
                                            constraints: const BoxConstraints(
                                              minWidth: 20,
                                              maxWidth: 250,
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        paddingChild: const EdgeInsets.all(6),
                                        color: Colors.grey.withOpacity(0.5),
                                        child: const Icon(Icons.add, size: 25),
                                      );
                                    } else {
                                      return buildEmailTag(index);
                                    }
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///date
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_calendar.png",
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if (selectedDate != null) {
                              _controller.pickedDate.value = selectedDate;
                            }
                          },
                          child: Obx(
                            () => Text(
                              FormatHelper().dateFormat(_controller.pickedDate.value),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    ///of event?
                    Row(
                      children: [
                        Obx(
                          () {
                            if (_controller.selectedEvent.value != null) {
                              return CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${_controller.selectedEvent.value!.icon}.png"),
                              );
                            } else {
                              return const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.hintColor,
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 30),
                        Obx(
                          () => Expanded(
                            child: TextField(
                              enabled: _controller.selectedWallet.value != null ? true : false,
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                var res = await Get.to(() => EventScreen(
                                      canChangeWallet: false,
                                      selectedWallet: _controller.selectedWallet.value,
                                    ));
                                if (res != null) {
                                  _controller.selectedEvent.value = res;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Ionicons.caret_down),
                                contentPadding: const EdgeInsets.only(top: 20),
                                hintText: _controller.selectedEvent.value?.name == null
                                    ? R.Oftheevent.tr
                                    : _controller.selectedEvent.value!.name,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ///button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: IconButton(
                      onPressed: () => _controller.pickedImageGallery(),
                      icon: const Icon(
                        Ionicons.image,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: IconButton(
                      onPressed: () => _controller.pickedImageCamera(),
                      icon: const Icon(
                        Ionicons.camera,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (_controller.pickedImage.value != null) {
                  return Stack(
                    children: [
                      Image.file(
                        File(_controller.pickedImage.value!),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.deleteImage();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Ionicons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  buildEmailTag(index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 7, top: 5, bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_controller.listUserGroup[index].email ?? '',
                style: const TextStyle(fontSize: 13)),
            InkWellWrapper(
              onTap: () => setState(() => _controller.listUserGroup.removeAt(index)),
              borderRadius: BorderRadius.circular(15),
              paddingChild: const EdgeInsets.all(5),
              child: const Icon(
                Icons.close,
                size: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}

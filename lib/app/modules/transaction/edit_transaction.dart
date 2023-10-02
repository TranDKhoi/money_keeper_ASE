import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/edit_transaction_controller.dart';
import 'package:money_keeper/data/services/services.dart';

import '../../../data/models/transaction.dart';
import '../../../data/models/user.dart';
import '../../common/widget/inkWell_wrapper.dart';
import '../../controllers/account/account_controller.dart';
import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../../routes/routes.dart';
import '../category/manage_category.dart';
import '../planning/event/event_screen.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({Key? key, required this.selectedTrans})
      : super(key: key);

  final Transaction selectedTrans;

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  Transaction tempTrans = Transaction();
  final _controller = Get.put(EditTransactionController());
  final walletController = Get.find<MyWalletController>();
  final AccountController _ac = Get.find();
  List<User> user = [];
  var tapPosition = const Offset(0.0, 0.0);
  bool isGetData = false;
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(locale: 'vi', decimalDigits: 0, symbol: "đ");

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    EasyLoading.show();
    var res = await TransactionService.ins.getTransactionByTransactionId(
        widget.selectedTrans.walletId!, widget.selectedTrans.id!);
    if (res.isOk) {
      tempTrans = Transaction.fromJson(res.body['data']);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
    user.clear();
    if (tempTrans.participants != null) {
      if (tempTrans.participants!.isNotEmpty) {
        _controller.listUserGroup.value = tempTrans.participants!;
      } else {
        _controller.listUserGroup.clear();
      }
    }
    if (tempTrans.wallet!.type == 'Group') {
      var kq = walletController.listGroupWallet
          .firstWhere((element) => element.id == tempTrans.walletId);
      kq.walletMembers?.forEach((element) {
        if (element.user!.email != _ac.currentUser.value!.email) {
          user.add(element.user!);
        }
      });
    }
    EasyLoading.dismiss();
    setState(() => isGetData = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Edittransaction.tr),
        actions: [
          TextButton(
            onPressed: () => _controller.updateTransaction(tempTrans),
            child: Text(R.Save.tr),
          ),
        ],
      ),
      body: isGetData
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue:
                                _formatter.format(tempTrans.amount.toString()),
                            onChanged: (val) {
                              if (val.trim().isEmpty) {
                                tempTrans.amount = 0;
                                return;
                              }
                              tempTrans.amount =
                                  int.parse(val.replaceAll(RegExp(r"\D"), ""));
                            },
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[_formatter],
                            decoration: const InputDecoration(
                              hintText: "VND",
                              hintStyle: TextStyle(
                                color: Colors.green,
                              ),
                              fillColor: Colors.transparent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          //wallet
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    "assets/icons/${tempTrans.wallet!.icon}.png"),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var res = await Get.toNamed(myWalletRoute,
                                        arguments: true);
                                    if (res != null) {
                                      if (res.id !=
                                          widget.selectedTrans.walletId) {
                                        tempTrans.category = null;
                                        setState(() {
                                          tempTrans.wallet = res;
                                        });
                                        _controller.listUserGroup.clear();
                                        user.clear();
                                        if (tempTrans.wallet!.type == 'Group') {
                                          tempTrans.wallet?.walletMembers
                                              ?.forEach((element) {
                                            if (element.user!.email !=
                                                _ac.currentUser.value!.email) {
                                              _controller.listUserGroup
                                                  .add(element.user!);
                                            }
                                          });
                                        }
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: tempTrans.wallet?.name ?? "",
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // //category
                          tempTrans.category == null
                              ? Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextField(
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          var res = await Get.to(
                                            ManageCategoryScreen(
                                              canChangeWallet: false,
                                              selectedWallet: tempTrans.wallet,
                                            ),
                                          );
                                          if (res != null) {
                                            setState(() {
                                              tempTrans.category = res;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon:
                                              const Icon(Ionicons.chevron_down),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20),
                                          hintText: R.Selectcategory.tr,
                                          fillColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/icons/${tempTrans.category!.icon}.png"),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextField(
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          var res = await Get.to(
                                            ManageCategoryScreen(
                                              canChangeWallet: false,
                                              selectedWallet: tempTrans.wallet,
                                            ),
                                          );
                                          if (res != null) {
                                            setState(() {
                                              tempTrans.category = res;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon:
                                              const Icon(Ionicons.chevron_down),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20),
                                          hintText: tempTrans.category!.name,
                                          fillColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 10),
                          // //note
                          Row(
                            children: [
                              const Icon(Ionicons.list_outline),
                              const SizedBox(width: 30),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) =>
                                      tempTrans.note = val.trim(),
                                  initialValue: tempTrans.note,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: R.Note.tr,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: tempTrans.wallet?.type == 'Group',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.groups,
                                      size: 35,
                                    ),
                                    const SizedBox(width: 20),
                                    Visibility(
                                      visible:
                                          _controller.listUserGroup.isEmpty,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            R.WithMember.tr,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 5,
                                        children: List.generate(
                                            _controller.listUserGroup.length +
                                                1, (index) {
                                          if (index ==
                                              _controller
                                                  .listUserGroup.length) {
                                            return InkWellWrapper(
                                              onTapDown: (details) {
                                                tapPosition =
                                                    details.globalPosition;
                                              },
                                              onTap: () {
                                                final RenderBox overlay =
                                                    Overlay.of(context)
                                                            ?.context
                                                            .findRenderObject()
                                                        as RenderBox;
                                                showMenu(
                                                  context: context,
                                                  position:
                                                      RelativeRect.fromRect(
                                                          tapPosition &
                                                              const Size(
                                                                  40, 40),
                                                          // smaller rect, the touch area
                                                          Offset.zero &
                                                              overlay
                                                                  .size // Bigger rect, the entire screen
                                                          ),
                                                  items: List.generate(
                                                      user.length, (index) {
                                                    return PopupMenuItem(
                                                      value: index,
                                                      onTap: () {
                                                        if (!_controller
                                                            .listUserGroup
                                                            .any((element) =>
                                                                element.email ==
                                                                user[index]
                                                                    .email)) {
                                                          setState(() {
                                                            _controller
                                                                .listUserGroup
                                                                .add(user[
                                                                    index]);
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                          user[index].email!),
                                                    );
                                                  }),
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 20,
                                                    maxWidth: 250,
                                                  ),
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              paddingChild:
                                                  const EdgeInsets.all(6),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              child: const Icon(Icons.add,
                                                  size: 25),
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
                          //date
                          Row(
                            children: [
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
                                    setState(() {
                                      tempTrans.createdAt = selectedDate;
                                    });
                                  }
                                },
                                child: Text(
                                  FormatHelper()
                                      .dateFormat(tempTrans.createdAt!),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //of event?
                          Row(
                            children: [
                              tempTrans.event != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/icons/${tempTrans.event?.icon}.png"),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                    ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextField(
                                  enabled:
                                      tempTrans.wallet != null ? true : false,
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    var res = await Get.to(() => EventScreen(
                                          canChangeWallet: false,
                                          selectedWallet: tempTrans.wallet,
                                        ));
                                    if (res != null) {
                                      setState(() {
                                        tempTrans.event = res;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        const Icon(Ionicons.chevron_down),
                                    contentPadding:
                                        const EdgeInsets.only(top: 20),
                                    hintText: tempTrans.event?.name ??
                                        R.Oftheevent.tr,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _controller.pickedImageGallery();
                              },
                              child: const Icon(
                                Ionicons.image,
                                size: 40,
                              ),
                            ),
                            const VerticalDivider(),
                            GestureDetector(
                              onTap: () async {
                                _controller.pickedImageCamera();
                              },
                              child: const Icon(
                                Ionicons.camera,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      if (_controller.pickedImage.value != null) {
                        return Stack(
                          children: [
                            Image.file(File(_controller.pickedImage.value ??
                                tempTrans.image!)),
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
                      } else {
                        if (tempTrans.image != null) {
                          return Stack(
                            children: [
                              Image.network(
                                tempTrans.image!,
                                errorBuilder: (context, _, __) =>
                                    const Center(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tempTrans.image == null;
                                  });
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
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      var res = await showDialog(
                        context: context,
                        builder: (_) => Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(R.Deletethistransactionquesttion.tr),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () =>
                                              Get.back(result: false),
                                          child: Text(R.No.tr)),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                          ),
                                          onPressed: () =>
                                              Get.back(result: true),
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
                        _controller.deleteTransaction(tempTrans);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Ionicons.trash,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          R.Deletethistransaction.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
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
              onTap: () =>
                  setState(() => _controller.listUserGroup.removeAt(index)),
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

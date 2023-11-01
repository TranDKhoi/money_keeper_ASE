import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/values/color.dart';
import 'package:money_keeper/app/core/values/style.dart';
import 'package:money_keeper/app/features/transaction/controller/edit_transaction_controller.dart';
import 'package:money_keeper/data/services/services.dart';

import '../../../data/models/transaction.dart';
import '../../../data/models/user.dart';
import '../../common/widget/inkwell_wrapper.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';
import '../account/controller/account_controller.dart';
import '../category/manage_category.dart';
import '../my_wallet/controller/my_wallet_controller.dart';
import '../planning/event/event_screen.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({Key? key, required this.selectedTrans}) : super(key: key);

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
    var res = await TransactionService.ins
        .getTransactionByTransactionId(widget.selectedTrans.walletId!, widget.selectedTrans.id!);
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
        title: Text(
          R.Edittransaction.tr,
          style: AppStyles.text24Bold,
        ),
        actions: [
          TextButton(
            onPressed: () => _controller.updateTransaction(tempTrans),
            child: Text(R.Save.tr),
          ),
        ],
      ),
      body: isGetData
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(top: 24),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        TextFormField(
                          initialValue: _formatter.format(tempTrans.amount.toString()),
                          onChanged: (val) {
                            if (val.trim().isEmpty) {
                              tempTrans.amount = 0;
                              return;
                            }
                            tempTrans.amount = int.parse(val.replaceAll(RegExp(r"\D"), ""));
                          },
                          style: AppStyles.text28Bold.copyWith(
                            color: AppColors.primaryColor,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[_formatter],
                          decoration: InputDecoration(
                            hintText: "VND",
                            hintStyle: AppStyles.text28Bold.copyWith(
                              color: AppColors.hintColor,
                            ),
                            suffixIcon: const Icon(Ionicons.create_outline),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //wallet
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: Image.asset("assets/icons/${tempTrans.wallet!.icon}.png"),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                onTap: () {},
                                controller: TextEditingController()
                                  ..text = tempTrans.wallet?.name ?? "",
                                decoration: InputDecoration(
                                  hintText: tempTrans.wallet?.name ?? "",
                                ),
                                style: AppStyles.text14Normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        ///category
                        tempTrans.category == null
                            ? Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.hintColor,
                                    radius: 25,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextField(
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
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
                                        suffixIcon: const Icon(Ionicons.caret_down),
                                        contentPadding: const EdgeInsets.only(top: 20),
                                        hintText: R.Selectcategory.tr,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child:
                                        Image.asset("assets/icons/${tempTrans.category!.icon}.png"),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextField(
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
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
                                        suffixIcon: const Icon(Ionicons.caret_down),
                                        contentPadding: const EdgeInsets.only(top: 20),
                                        hintText: tempTrans.category!.name,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 20),

                        /// note
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/ic_note.png",
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) => tempTrans.note = val.trim(),
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
                                    visible: _controller.listUserGroup.isEmpty,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          R.WithMember.tr,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: List.generate(_controller.listUserGroup.length + 1,
                                          (index) {
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
                                                        overlay
                                                            .size // Bigger rect, the entire screen
                                                    ),
                                                items: List.generate(user.length, (index) {
                                                  return PopupMenuItem(
                                                    value: index,
                                                    onTap: () {
                                                      if (!_controller.listUserGroup.any(
                                                          (element) =>
                                                              element.email == user[index].email)) {
                                                        setState(() {
                                                          _controller.listUserGroup
                                                              .add(user[index]);
                                                        });
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
                                  setState(() {
                                    tempTrans.createdAt = selectedDate;
                                  });
                                }
                              },
                              child: Text(
                                FormatHelper().dateFormat(tempTrans.createdAt!),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        ///of event?
                        Row(
                          children: [
                            tempTrans.event != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: Image.asset("assets/icons/${tempTrans.event?.icon}.png"),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: AppColors.hintColor,
                                    radius: 25,
                                  ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                enabled: tempTrans.wallet != null ? true : false,
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
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
                                  suffixIcon: const Icon(Ionicons.caret_down),
                                  contentPadding: const EdgeInsets.only(top: 20),
                                  hintText: tempTrans.event?.name ?? R.Oftheevent.tr,
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

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

                    Obx(
                      () {
                        if (_controller.pickedImage.value != null) {
                          return Stack(
                            children: [
                              Image.file(File(_controller.pickedImage.value ?? tempTrans.image!)),
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
                                  errorBuilder: (context, _, __) => const Center(),
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

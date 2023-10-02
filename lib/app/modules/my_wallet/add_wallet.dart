import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/common/widget/money_field.dart';
import 'package:money_keeper/data/models/wallet.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../controllers/account/account_controller.dart';
import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({Key? key}) : super(key: key);

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final MyWalletController _controller = Get.find()..getAllCategoryGroup();
  final TextfieldTagsController _tagController = TextfieldTagsController();
  bool isGroupWallet = false;
  final AccountController _ac = Get.find();
  final textWalletName = TextEditingController();
  final textWalletBalance = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _tagController.dispose();
    textWalletName.dispose();
    textWalletBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //app bar
      appBar: AppBar(
        title: isGroupWallet ? Text(R.Addgroupwallet.tr) : Text(R.Addwallet.tr),
        actions: [
          Row(
            children: [
              Text(R.Groupwallet.tr),
              Switch(
                  value: isGroupWallet,
                  onChanged: (val) {
                    _controller.listMember.clear();
                    setState(() {
                      isGroupWallet = val;
                    });
                  }),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //wallet name and icon
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var res = await showModalBottomSheet<int>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const IconModalBottomSheet());

                          if (res != null) {
                            _controller.selectedCategoryPic.value = res;
                          }
                        },
                        child: Obx(() {
                          if (_controller.selectedCategoryPic.value != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${_controller.selectedCategoryPic.value}.png"),
                            );
                          }
                          return const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          );
                        }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: textWalletName,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: R.Walletname.tr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //wallet balance
                  Row(
                    children: [
                      const Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MoneyField(
                          controller: textWalletBalance,
                          hintText: R.Balance.tr,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //wallet category list
                  Row(
                    children: [
                      const Icon(
                        Ionicons.list_outline,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => DropdownButton<Wallet>(
                          value: _controller.selectedCategoryGroup.value,
                          items:
                              _controller.categoryGroupList.map((Wallet value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                "  ${value.name!}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            _controller.selectedCategoryGroup.value = val!;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      R.instructionofcategorylist.tr,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Ionicons.information_circle_outline,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isGroupWallet,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.groups,
                              size: 30,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              R.Addmembers.tr,
                              style: const TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFieldTags(
                          textfieldTagsController: _tagController,
                          inputfieldBuilder: (context, tec, fn, error,
                              onChanged, onSubmitted) {
                            return ((context, sc, tags, onTagDelete) {
                              return TextField(
                                controller: tec,
                                focusNode: fn,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: _tagController.hasTags
                                      ? ''
                                      : "Enter email...",
                                  errorText: error,
                                  prefixIcon: tags.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: sc,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: tags.map((String tag) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Colors.green,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        tag,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () {
                                                        print("$tag selected");
                                                      },
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color: Colors.white,
                                                      ),
                                                      onTap: () {
                                                        _controller.listMember
                                                            .removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .email ==
                                                                    tag);
                                                        onTagDelete(tag);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      : null,
                                ),
                                onChanged: onChanged,
                                onSubmitted: (result) async {
                                  if (result == _ac.currentUser.value!.email) {
                                    EasyLoading.showToast(R.yourOwnerWallet);
                                    tec.clear();
                                    return;
                                  }
                                  await _controller
                                      .checkAlreadyUser(email: result)
                                      .then((value) {
                                    if (value == false) {
                                      EasyLoading.showToast(R.emailNotExits);
                                      tec.clear();
                                      return null;
                                    } else if (_tagController.getTags!
                                        .contains(result)) {
                                      EasyLoading.showToast(R.emailEnteredThat);
                                      tec.clear();
                                      return null;
                                    }
                                    onSubmitted?.call(result);
                                  });
                                },
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //include in total
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            isThreeLine: true,
            title: Text(R.Notincludeintotalbalance.tr),
            subtitle:
                Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
          ),
          const Spacer(),
          //add new Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: _createNewWallet,
              child: Text(R.ADDNEW.tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _createNewWallet() {
    if (isGroupWallet) {
      if (textWalletBalance.text.isEmpty ||
          textWalletName.text.isEmpty ||
          _controller.selectedCategoryPic.value == null ||
          _controller.listMember.isEmpty) {
        EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
        return;
      }
      final newWallet = Wallet(
          balance: int.parse(
              textWalletBalance.text.trim().replaceAll(RegExp(r"\D"), "")),
          name: textWalletName.text.trim(),
          type: "Group",
          icon: _controller.selectedCategoryPic.value.toString(),
          memberIds: []);
      for (var element in _controller.listMember) {
        newWallet.memberIds?.add(element.id!);
      }

      if (_controller.selectedCategoryGroup.value.id != -1) {
        newWallet.clonedCategoryWalletId =
            _controller.selectedCategoryGroup.value.id;
      }
      _controller.createNewWallet(newWallet);
    } else {
      if (textWalletBalance.text.isEmpty ||
          textWalletName.text.isEmpty ||
          _controller.selectedCategoryPic.value == null) {
        EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
        return;
      }
      final newWallet = Wallet(
          balance: int.parse(
              textWalletBalance.text.trim().replaceAll(RegExp(r"\D"), "")),
          name: textWalletName.text.trim(),
          type: "Personal",
          icon: _controller.selectedCategoryPic.value.toString(),
          memberIds: []);
      if (_controller.selectedCategoryGroup.value.id != -1) {
        newWallet.clonedCategoryWalletId =
            _controller.selectedCategoryGroup.value.id;
      }
      _controller.createNewWallet(newWallet);
    }
  }
}

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/wallet/my_wallet_controller.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../data/models/wallet.dart';
import '../../controllers/account/account_controller.dart';
import '../../core/values/r.dart';
import '../category/widgets/category_icon_modal.dart';

class EditWalletScreen extends StatefulWidget {
  const EditWalletScreen({Key? key}) : super(key: key);

  @override
  State<EditWalletScreen> createState() => _EditWalletScreenState();
}

class _EditWalletScreenState extends State<EditWalletScreen> {
  final MyWalletController _controller = Get.find();
  final AccountController _ac = Get.find();
  final selectedWallet = Get.arguments as Wallet;
  late final textWalletName = TextEditingController(text: selectedWallet.name);
  late final textWalletBalance =
      TextEditingController(text: selectedWallet.balance.toString());
  final TextfieldTagsController _tagController = TextfieldTagsController();
  late List<String> listMembers = [];
  late bool isGroupWallet = selectedWallet.type == 'Group' ? true : false;

  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(locale: 'vi', decimalDigits: 0, symbol: "đ");

  @override
  void initState() {
    selectedWallet.walletMembers?.forEach((element) {
      if (element.user!.email! != _ac.currentUser.value!.email) {
        listMembers.add(element.user!.email!);
        _controller.listMember.add(element.user!);
      }
    });
    _controller.selectedCategoryPic.value =
        int.parse(selectedWallet.icon ?? "0");
    super.initState();
  }

  @override
  void dispose() {
    _controller.selectedCategoryPic.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(R.Editwallet.tr),
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
                          if (selectedWallet.icon != null) {
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  "assets/icons/${selectedWallet.icon}.png"),
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
                        child: TextFormField(
                          controller: textWalletName,
                          onChanged: (s) {},
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
                  Row(
                    children: [
                      const Icon(
                        Ionicons.trending_up,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          initialValue:
                              _formatter.format(textWalletBalance.text),
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            textWalletBalance.text =
                                val.trim().replaceAll(RegExp(r"\D"), "");
                          },
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                          ),
                          inputFormatters: [_formatter],
                          decoration: const InputDecoration(
                            hintText: "VND",
                            hintStyle: TextStyle(
                              color: Colors.green,
                            ),
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                              R.memberGroup.tr,
                              style: const TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFieldTags(
                          textfieldTagsController: _tagController,
                          initialTags: listMembers,
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
                                                        horizontal: 5),
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
                                      return;
                                    } else if (_tagController.getTags!
                                        .contains(result)) {
                                      EasyLoading.showToast(R.emailEnteredThat);
                                      tec.clear();
                                      return;
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
                  )
                ],
              ),
            ),
          ),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            isThreeLine: true,
            title: Text(R.Notincludeintotalbalance.tr),
            subtitle:
                Text(R.Createanewwalletanddonotincludeitintototalbalance.tr),
          ),
          const SizedBox(height: 30),
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
                          Text(R.DELETETHISWALLETFOREVER.tr),
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
                _controller.deleteWallet(selectedWallet.id);
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
                  R.DELETETHISWALLETFOREVER.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                if (isGroupWallet) {
                  if (textWalletBalance.text.isEmpty ||
                      textWalletName.text.isEmpty ||
                      _controller.selectedCategoryPic.value == null ||
                      _controller.listMember.isEmpty) {
                    EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
                    return;
                  }
                  final newWallet = Wallet(
                      id: selectedWallet.id,
                      balance: int.parse(textWalletBalance.text),
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
                  _controller.updateWallet(newWallet);
                } else {
                  if (textWalletBalance.text.isEmpty ||
                      _controller.selectedCategoryPic.value == null ||
                      textWalletName.text.isEmpty) {
                    EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
                    return;
                  }
                  final newWallet = Wallet(
                    id: selectedWallet.id,
                    balance: int.parse(textWalletBalance.text),
                    name: textWalletName.text.trim(),
                    type: "Personal",
                    icon: _controller.selectedCategoryPic.value.toString(),
                  );
                  if (_controller.selectedCategoryGroup.value.id != -1) {
                    newWallet.clonedCategoryWalletId =
                        _controller.selectedCategoryGroup.value.id;
                  }
                  _controller.updateWallet(newWallet);
                }
              },
              child: Text(R.UPDATE.tr),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

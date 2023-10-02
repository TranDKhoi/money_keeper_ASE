import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/user.dart';
import 'package:money_keeper/data/models/wallet_member.dart';

part "wallet.g.dart";

@JsonSerializable(explicitToJson: true)
class Wallet {
  int? id;
  String? name;
  String? icon;
  int? balance;
  bool? isDefault;
  String? type;
  int? clonedCategoryWalletId;
  List<WalletMember>? walletMembers;
  List<int>? memberIds;

  Wallet(
      {this.id,
      this.name,
      this.icon,
      this.balance,
      this.isDefault,
      this.type,
      this.clonedCategoryWalletId,
      this.walletMembers,
      this.memberIds});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

import 'user.dart';
import 'wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part "wallet_member.g.dart";

@JsonSerializable(explicitToJson: true)
class WalletMember {
  int? userId;
  User? user;
  int? walletId;
  Wallet? wallet;
  String? status;
  String? role;
  DateTime? joinAt;

  WalletMember({
    this.userId,
    this.user,
    this.walletId,
    this.wallet,
    this.status,
    this.role,
    this.joinAt
});

  factory WalletMember.fromJson(Map<String, dynamic> json) => _$WalletMemberFromJson(json);
  Map<String, dynamic> toJson() => _$WalletMemberToJson(this);
}
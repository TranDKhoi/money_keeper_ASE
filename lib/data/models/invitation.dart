
import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/user.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'invitation.g.dart';

@JsonSerializable(explicitToJson: true)
class Invitation{
  int? id;
  DateTime? createdAt;
  DateTime? expirationDate;
  int? walletId;
  Wallet? wallet;
  int? senderId;
  User? sender;
  String? status;

  Invitation({this.id, this.createdAt, this.expirationDate, this.walletId,
      this.wallet, this.senderId, this.sender, this.status});

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}
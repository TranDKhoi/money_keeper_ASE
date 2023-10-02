import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/budget.dart';
import 'package:money_keeper/data/models/transaction.dart';
import 'package:money_keeper/data/models/user.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'notify.g.dart';

@JsonSerializable()
class Notify {
  int? id;
  String? description;
  String? type;
  int? userId;
  User? user;
  int? walletId;
  Wallet? wallet;
  int? transactionId;
  Transaction? transaction;
  int? budgetId;
  DateTime? createdAt;
  Budget? budget;
  bool? isSeen;

  Notify(
      {this.id,
      this.description,
      this.type,
      this.userId,
      this.user,
      this.walletId,
      this.wallet,
      this.transactionId,
      this.transaction,
      this.budgetId,
      this.createdAt,
      this.budget,
      this.isSeen});

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}

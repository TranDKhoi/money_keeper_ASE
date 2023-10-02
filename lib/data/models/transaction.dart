import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/event.dart';

import 'category.dart';
import 'user.dart';
import 'wallet.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction {
  int? id;
  int? amount;
  String? note;
  int? categoryId;
  int? walletId;
  Wallet? wallet;
  Category? category;
  int? eventId;
  Event? event;
  String? image;
  DateTime? createdAt;
  List<int>? participantIds;
  List<User>? participants;

  Transaction(
      {this.id,
      this.amount,
      this.note,
      this.categoryId,
      this.walletId,
      this.wallet,
      this.category,
      this.eventId,
      this.event,
      this.image,
      this.createdAt,
      this.participantIds,
      this.participants});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

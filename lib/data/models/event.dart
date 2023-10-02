import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/transactions_by_day.dart';
import 'package:money_keeper/data/models/transactions_by_time.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  int? id;
  DateTime? createdAt;
  DateTime? endDate;
  String? name;
  String? icon;
  int? spentAmount;
  Wallet? wallet;
  int? walletId;
  bool? isFinished;

  Event({
    this.id,
    this.createdAt,
    this.endDate,
    this.name,
    this.icon,
    this.spentAmount,
    this.wallet,
    this.isFinished,
    this.walletId,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

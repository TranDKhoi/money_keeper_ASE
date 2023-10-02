import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/transactions_by_day.dart';

part 'transactions_by_time.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionsByTime {
  int? totalIncome;
  int? totalExpense;
  List<TransactionsByDay>? details;

  TransactionsByTime({this.totalIncome, this.totalExpense, this.details});

  factory TransactionsByTime.fromJson(Map<String, dynamic> json) =>
      _$TransactionsByTimeFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsByTimeToJson(this);
}

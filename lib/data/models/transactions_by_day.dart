import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/transaction.dart';

part 'transactions_by_day.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionsByDay {
  DateTime? date;
  int? revenue;
  List<Transaction>? transactions;

  TransactionsByDay({this.date, this.revenue, this.transactions});

  factory TransactionsByDay.fromJson(Map<String, dynamic> json) =>
      _$TransactionsByDayFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsByDayToJson(this);
}

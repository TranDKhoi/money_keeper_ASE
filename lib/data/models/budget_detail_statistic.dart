import 'package:json_annotation/json_annotation.dart';

part 'budget_detail_statistic.g.dart';

@JsonSerializable()
class BudgetDetailStatistic {
  DateTime? date;
  int? expenseAmount;
  BudgetDetailStatistic({
    this.date,
    this.expenseAmount,
  });

  factory BudgetDetailStatistic.fromJson(Map<String, dynamic> json) =>
      _$BudgetDetailStatisticFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetDetailStatisticToJson(this);
}

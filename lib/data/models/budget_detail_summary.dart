import 'package:json_annotation/json_annotation.dart';

part 'budget_detail_summary.g.dart';

@JsonSerializable()
class BudgetDetailSummary {
  int? totalBudget;
  int? totalSpentAmount;
  double? recommendedDailyExpense;
  double? realDailyExpense;
  double? expectedExpense;
  BudgetDetailSummary({
    this.totalBudget,
    this.totalSpentAmount,
    this.recommendedDailyExpense,
    this.realDailyExpense,
    this.expectedExpense,
  });

  factory BudgetDetailSummary.fromJson(Map<String, dynamic> json) =>
      _$BudgetDetailSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetDetailSummaryToJson(this);
}

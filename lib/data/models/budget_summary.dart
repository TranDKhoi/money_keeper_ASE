import 'package:json_annotation/json_annotation.dart';

part 'budget_summary.g.dart';

@JsonSerializable()
class BudgetSummary {
  int? totalBudget;
  int? totalSpentAmount;
  BudgetSummary({
    this.totalBudget,
    this.totalSpentAmount,
  });

  factory BudgetSummary.fromJson(Map<String, dynamic> json) =>
      _$BudgetSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetSummaryToJson(this);
}

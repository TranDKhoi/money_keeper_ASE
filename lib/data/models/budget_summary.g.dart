// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetSummary _$BudgetSummaryFromJson(Map<String, dynamic> json) =>
    BudgetSummary(
      totalBudget: json['totalBudget'] as int?,
      totalSpentAmount: json['totalSpentAmount'] as int?,
    );

Map<String, dynamic> _$BudgetSummaryToJson(BudgetSummary instance) =>
    <String, dynamic>{
      'totalBudget': instance.totalBudget,
      'totalSpentAmount': instance.totalSpentAmount,
    };

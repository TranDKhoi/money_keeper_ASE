// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_detail_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetDetailSummary _$BudgetDetailSummaryFromJson(Map<String, dynamic> json) =>
    BudgetDetailSummary(
      totalBudget: json['totalBudget'] as int?,
      totalSpentAmount: json['totalSpentAmount'] as int?,
      recommendedDailyExpense:
          (json['recommendedDailyExpense'] as num?)?.toDouble(),
      realDailyExpense: (json['realDailyExpense'] as num?)?.toDouble(),
      expectedExpense: (json['expectedExpense'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BudgetDetailSummaryToJson(
        BudgetDetailSummary instance) =>
    <String, dynamic>{
      'totalBudget': instance.totalBudget,
      'totalSpentAmount': instance.totalSpentAmount,
      'recommendedDailyExpense': instance.recommendedDailyExpense,
      'realDailyExpense': instance.realDailyExpense,
      'expectedExpense': instance.expectedExpense,
    };

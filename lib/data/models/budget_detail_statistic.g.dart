// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_detail_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetDetailStatistic _$BudgetDetailStatisticFromJson(
        Map<String, dynamic> json) =>
    BudgetDetailStatistic(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      expenseAmount: json['expenseAmount'] as int?,
    );

Map<String, dynamic> _$BudgetDetailStatisticToJson(
        BudgetDetailStatistic instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'expenseAmount': instance.expenseAmount,
    };

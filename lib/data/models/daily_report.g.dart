// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReport _$DailyReportFromJson(Map<String, dynamic> json) => DailyReport(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      income: json['income'] as int?,
      expense: json['expense'] as int?,
    );

Map<String, dynamic> _$DailyReportToJson(DailyReport instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'income': instance.income,
      'expense': instance.expense,
    };

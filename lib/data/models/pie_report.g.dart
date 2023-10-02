// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PieReport _$PieReportFromJson(Map<String, dynamic> json) => PieReport(
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$PieReportToJson(PieReport instance) => <String, dynamic>{
      'category': instance.category,
      'amount': instance.amount,
    };

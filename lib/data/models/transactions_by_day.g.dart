// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_by_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsByDay _$TransactionsByDayFromJson(Map<String, dynamic> json) =>
    TransactionsByDay(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      revenue: json['revenue'] as int?,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionsByDayToJson(TransactionsByDay instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'revenue': instance.revenue,
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_by_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsByTime _$TransactionsByTimeFromJson(Map<String, dynamic> json) =>
    TransactionsByTime(
      totalIncome: json['totalIncome'] as int?,
      totalExpense: json['totalExpense'] as int?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => TransactionsByDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionsByTimeToJson(TransactionsByTime instance) =>
    <String, dynamic>{
      'totalIncome': instance.totalIncome,
      'totalExpense': instance.totalExpense,
      'details': instance.details?.map((e) => e.toJson()).toList(),
    };

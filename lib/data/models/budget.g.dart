// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      id: json['id'] as int?,
      spentAmount: json['spentAmount'] as int?,
      limitAmount: json['limitAmount'] as int?,
      month: json['month'] as int?,
      year: json['year'] as int?,
      categoryId: json['categoryId'] as int?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      walletId: json['walletId'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      creatorId: json['creatorId'] as int?,
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
      'id': instance.id,
      'spentAmount': instance.spentAmount,
      'limitAmount': instance.limitAmount,
      'month': instance.month,
      'year': instance.year,
      'categoryId': instance.categoryId,
      'category': instance.category?.toJson(),
      'walletId': instance.walletId,
      'wallet': instance.wallet?.toJson(),
      'creatorId': instance.creatorId,
      'creator': instance.creator?.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) => Notify(
      id: json['id'] as int?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      userId: json['userId'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      walletId: json['walletId'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as int?,
      transaction: json['transaction'] == null
          ? null
          : Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      budgetId: json['budgetId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      budget: json['budget'] == null
          ? null
          : Budget.fromJson(json['budget'] as Map<String, dynamic>),
      isSeen: json['isSeen'] as bool?,
    );

Map<String, dynamic> _$NotifyToJson(Notify instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'type': instance.type,
      'userId': instance.userId,
      'user': instance.user,
      'walletId': instance.walletId,
      'wallet': instance.wallet,
      'transactionId': instance.transactionId,
      'transaction': instance.transaction,
      'budgetId': instance.budgetId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'budget': instance.budget,
      'isSeen': instance.isSeen,
    };

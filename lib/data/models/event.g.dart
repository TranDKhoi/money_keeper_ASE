// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      spentAmount: json['spentAmount'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      isFinished: json['isFinished'] as bool?,
      walletId: json['walletId'] as int?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'name': instance.name,
      'icon': instance.icon,
      'spentAmount': instance.spentAmount,
      'wallet': instance.wallet,
      'walletId': instance.walletId,
      'isFinished': instance.isFinished,
    };

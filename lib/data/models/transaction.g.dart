// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
      note: json['note'] as String?,
      categoryId: json['categoryId'] as int?,
      walletId: json['walletId'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      eventId: json['eventId'] as int?,
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      image: json['image'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      participantIds: (json['participantIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'note': instance.note,
      'categoryId': instance.categoryId,
      'walletId': instance.walletId,
      'wallet': instance.wallet?.toJson(),
      'category': instance.category?.toJson(),
      'eventId': instance.eventId,
      'event': instance.event?.toJson(),
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'participantIds': instance.participantIds,
      'participants': instance.participants?.map((e) => e.toJson()).toList(),
    };

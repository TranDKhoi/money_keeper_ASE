// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletMember _$WalletMemberFromJson(Map<String, dynamic> json) => WalletMember(
      userId: json['userId'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      walletId: json['walletId'] as int?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      status: json['status'] as String?,
      role: json['role'] as String?,
      joinAt: json['joinAt'] == null
          ? null
          : DateTime.parse(json['joinAt'] as String),
    );

Map<String, dynamic> _$WalletMemberToJson(WalletMember instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'user': instance.user?.toJson(),
      'walletId': instance.walletId,
      'wallet': instance.wallet?.toJson(),
      'status': instance.status,
      'role': instance.role,
      'joinAt': instance.joinAt?.toIso8601String(),
    };

import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  int? id;
  String? name;
  String? icon;
  String? type;
  String? group;
  int? walletId;
  Wallet? wallet;

  Category({this.id, this.name, this.icon, this.type, this.walletId,this.wallet});
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

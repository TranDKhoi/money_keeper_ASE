import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/category.dart';
import 'package:money_keeper/data/models/user.dart';
import 'package:money_keeper/data/models/wallet.dart';

part 'budget.g.dart';

@JsonSerializable(explicitToJson: true)
class Budget {
  int? id;
  int? spentAmount;
  int? limitAmount;
  int? month;
  int? year;
  int? categoryId;
  Category? category;
  int? walletId;
  Wallet? wallet;
  int? creatorId;
  User? creator;
  Budget({
    this.id,
    this.spentAmount,
    this.limitAmount,
    this.month,
    this.year,
    this.categoryId,
    this.category,
    this.walletId,
    this.wallet,
    this.creatorId,
    this.creator,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}

import 'dart:convert';

class CreateBudget {
  int? limitAmount;
  int? month;
  int? year;
  int? categoryId;
  int? walletId;
  CreateBudget({
    this.limitAmount,
    this.month,
    this.year,
    this.categoryId,
    this.walletId,
  });

  Map<String, dynamic> toMap() {
    return {
      'limitAmount': limitAmount,
      'month': month,
      'year': year,
      'categoryId': categoryId,
      'walletId': walletId,
    };
  }

  factory CreateBudget.fromMap(Map<String, dynamic> map) {
    return CreateBudget(
      limitAmount: map['limitAmount']?.toInt(),
      month: map['month']?.toInt(),
      year: map['year']?.toInt(),
      categoryId: map['categoryId']?.toInt(),
      walletId: map['walletId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBudget.fromJson(String source) =>
      CreateBudget.fromMap(json.decode(source));
}

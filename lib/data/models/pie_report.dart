import 'package:json_annotation/json_annotation.dart';
import 'package:money_keeper/data/models/category.dart';

part 'pie_report.g.dart';
@JsonSerializable()
class PieReport{
  Category category;
  int amount;

  PieReport({required this.category, required this.amount});

  factory PieReport.fromJson(Map<String, dynamic> json) =>
      _$PieReportFromJson(json);

  Map<String, dynamic> toJson() => _$PieReportToJson(this);
}
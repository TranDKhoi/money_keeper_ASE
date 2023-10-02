
import 'package:json_annotation/json_annotation.dart';

part 'daily_report.g.dart';

@JsonSerializable()
class DailyReport {
  DateTime? date;
  int? income;
  int? expense;

  DailyReport({this.date, this.income, this.expense});

  factory DailyReport.fromJson(Map<String, dynamic> json) => _$DailyReportFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportToJson(this);
}

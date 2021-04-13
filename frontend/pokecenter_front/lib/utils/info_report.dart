import 'package:json_annotation/json_annotation.dart';

part 'info_report.g.dart';

@JsonSerializable()
class InfoReport {
  String title = "";
  String text = "";
  String srcUrl = "";
  bool isActive = false;

  InfoReport(this.title, this.text, this.srcUrl) {
    this.isActive = true;
  }

  factory InfoReport.fromJson(Map<String, dynamic> json) {
    return _$InfoReportFromJson(json);
  }

  toJson() {
    return _$InfoReportToJson(this);
  }
}

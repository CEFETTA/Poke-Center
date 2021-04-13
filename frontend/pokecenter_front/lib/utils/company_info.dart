import 'package:json_annotation/json_annotation.dart';

part 'company_info.g.dart';

@JsonSerializable()
class CompanyInfo {
  String text = "";
  String srcUrl = "";

  CompanyInfo(this.text, this.srcUrl);

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return _$CompanyInfoFromJson(json);
  }

  toJson() {
    return _$CompanyInfoToJson(this);
  }
}

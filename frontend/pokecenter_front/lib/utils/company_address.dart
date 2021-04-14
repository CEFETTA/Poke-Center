import 'package:json_annotation/json_annotation.dart';

part 'company_address.g.dart';

@JsonSerializable()
class CompanyAddress {
  String text = "";
  String srcUrl = "";
  String mapsUrl = "";

  CompanyAddress(this.text, this.srcUrl, this.mapsUrl);

  factory CompanyAddress.fromJson(Map<String, dynamic> json) {
    return _$CompanyAddressFromJson(json);
  }

  toJson() {
    return _$CompanyAddressToJson(this);
  }
}

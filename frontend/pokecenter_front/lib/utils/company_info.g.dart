// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyInfo _$CompanyInfoFromJson(Map<String, dynamic> json) {
  return CompanyInfo(
    json['text'] as String,
    json['srcUrl'] as String,
  );
}

Map<String, dynamic> _$CompanyInfoToJson(CompanyInfo instance) =>
    <String, dynamic>{
      'text': instance.text,
      'srcUrl': instance.srcUrl,
    };

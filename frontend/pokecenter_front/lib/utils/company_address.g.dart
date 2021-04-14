// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyAddress _$CompanyAddressFromJson(Map<String, dynamic> json) {
  return CompanyAddress(
    json['text'] as String,
    json['srcUrl'] as String,
    json['mapsUrl'] as String,
  );
}

Map<String, dynamic> _$CompanyAddressToJson(CompanyAddress instance) =>
    <String, dynamic>{
      'text': instance.text,
      'srcUrl': instance.srcUrl,
      'mapsUrl': instance.mapsUrl,
    };

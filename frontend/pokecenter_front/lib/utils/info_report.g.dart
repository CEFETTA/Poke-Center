// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoReport _$InfoReportFromJson(Map<String, dynamic> json) {
  return InfoReport(
    json['title'] as String,
    json['text'] as String,
    json['srcUrl'] as String,
  )..isActive = json['isActive'] as bool;
}

Map<String, dynamic> _$InfoReportToJson(InfoReport instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'srcUrl': instance.srcUrl,
      'isActive': instance.isActive,
    };

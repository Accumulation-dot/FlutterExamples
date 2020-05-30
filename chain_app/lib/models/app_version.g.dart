// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) {
  return AppVersion(
    json['version'] as String,
    json['flag'] as int,
    json['app'] as String,
  );
}

Map<String, dynamic> _$AppVersionToJson(AppVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'flag': instance.flag,
      'app': instance.app,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    (json['coin'] as num)?.toDouble(),
    json['created'] as String,
    (json['frozen'] as num)?.toDouble(),
    json['address'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'coin': instance.coin,
      'created': instance.created,
      'frozen': instance.frozen,
      'address': instance.address,
      'token': instance.token,
    };

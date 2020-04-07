// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advert_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertList _$AdvertListFromJson(Map<String, dynamic> json) {
  return AdvertList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : AdvertItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AdvertListToJson(AdvertList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

AdvertItem _$AdvertItemFromJson(Map<String, dynamic> json) {
  return AdvertItem(
    json['id'] as int,
    json['user'] == null
        ? null
        : UserSummary.fromJson(json['user'] as Map<String, dynamic>),
    json['title'] as String,
    json['img'] as String,
    json['url'] as String,
    json['content'] as String,
    json['datetime'] as String,
  )..username = json['username'] as String;
}

Map<String, dynamic> _$AdvertItemToJson(AdvertItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'username': instance.username,
      'title': instance.title,
      'img': instance.img,
      'url': instance.url,
      'content': instance.content,
      'datetime': instance.datetime,
    };

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return UserSummary(
    (json['coin'] as num)?.toDouble(),
    json['created'] as String,
    (json['frozen'] as num)?.toDouble(),
    json['address'] as String,
  );
}

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'created': instance.created,
      'frozen': instance.frozen,
      'address': instance.address,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsList _$NewsListFromJson(Map<String, dynamic> json) {
  return NewsList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : NewsItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewsListToJson(NewsList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) {
  return NewsItem(
    json['id'] as int,
    json['title'] as String,
    json['img'] as String,
    json['url'] as String,
    json['datetime'] as String,
  );
}

Map<String, dynamic> _$NewsItemToJson(NewsItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'img': instance.img,
      'url': instance.url,
      'datetime': instance.datetime,
    };

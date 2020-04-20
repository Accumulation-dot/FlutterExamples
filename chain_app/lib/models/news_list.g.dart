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
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewsListToJson(NewsList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    json['id'] as String,
    json['img'] as String,
    json['title'] as String,
    json['url'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'title': instance.title,
      'url': instance.url,
      'date': instance.date,
    };

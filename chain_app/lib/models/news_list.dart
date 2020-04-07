import 'package:json_annotation/json_annotation.dart';

part 'news_list.g.dart';

@JsonSerializable()
class NewsList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<NewsItem> list;

  NewsList(
    this.count,
    this.next,
    this.list,
  );

  factory NewsList.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsListToJson(this);
}

@JsonSerializable()
class NewsItem extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'datetime')
  String datetime;

  NewsItem(
    this.id,
    this.title,
    this.img,
    this.url,
    this.datetime,
  );

  factory NewsItem.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}

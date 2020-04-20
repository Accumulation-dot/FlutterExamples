import 'package:json_annotation/json_annotation.dart'; 
  
part 'news_list.g.dart';


@JsonSerializable()
  class NewsList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<News> list;

  NewsList(this.count,this.next,this.list,);

  factory NewsList.fromJson(Map<String, dynamic> srcJson) => _$NewsListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsListToJson(this);

}

  
@JsonSerializable()
  class News extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'date')
  String date;

  News(this.id,this.img,this.title,this.url,this.date,);

  factory News.fromJson(Map<String, dynamic> srcJson) => _$NewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

}

  

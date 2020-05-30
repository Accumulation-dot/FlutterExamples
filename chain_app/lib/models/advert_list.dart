import 'package:json_annotation/json_annotation.dart';

part 'advert_list.g.dart';

@JsonSerializable()
class AdvertList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<AdvertItem> list;

  AdvertList(
    this.count,
    this.next,
    this.list,
  );

  factory AdvertList.fromJson(Map<String, dynamic> srcJson) =>
      _$AdvertListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdvertListToJson(this);
}

@JsonSerializable()
class AdvertItem extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'user')
  String user;
  //UserSummary user;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'datetime')
  String datetime;

  AdvertItem(
    this.id,
    this.user,
    this.title,
    this.img,
    this.url,
    this.content,
    this.datetime,
  );

  factory AdvertItem.fromJson(Map<String, dynamic> srcJson) =>
      _$AdvertItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdvertItemToJson(this);
}

@JsonSerializable()
class UserSummary extends Object {
  @JsonKey(name: 'coin')
  double coin;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'frozen')
  double frozen;

  @JsonKey(name: 'address')
  String address;

  UserSummary(
    this.coin,
    this.created,
    this.frozen,
    this.address,
  );

  factory UserSummary.fromJson(Map<String, dynamic> srcJson) =>
      _$UserSummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserSummaryToJson(this);
}

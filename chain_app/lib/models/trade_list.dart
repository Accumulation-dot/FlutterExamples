import 'package:chain_app/models/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trade_list.g.dart';

@JsonSerializable()
class TradeList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<TradeItem> list;

  TradeList(
    this.count,
    this.next,
    this.list,
  );

  factory TradeList.fromJson(Map<String, dynamic> srcJson) =>
      _$TradeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TradeListToJson(this);
}

@JsonSerializable()
class TradeItem extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type_desc')
  String typeDesc;

  @JsonKey(name: 'user')
  UserInfo user;

  @JsonKey(name: 'status_desc')
  String statusDesc;

  @JsonKey(name: 'number')
  double number;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'status')
  int status;

  TradeItem(
    this.id,
    this.typeDesc,
    this.user,
    this.statusDesc,
    this.number,
    this.type,
    this.status,
  );

  factory TradeItem.fromJson(Map<String, dynamic> srcJson) =>
      _$TradeItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TradeItemToJson(this);
}

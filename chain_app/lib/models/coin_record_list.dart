import 'package:json_annotation/json_annotation.dart'; 
  
part 'coin_record_list.g.dart';


@JsonSerializable()
  class CoinRecordList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<CoinRecord> list;

  CoinRecordList(this.count,this.next,this.list,);

  factory CoinRecordList.fromJson(Map<String, dynamic> srcJson) => _$CoinRecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CoinRecordListToJson(this);

}

  
@JsonSerializable()
  class CoinRecord extends Object {

  @JsonKey(name: 'datetime')
  String datetime;

  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'point')
  double point;

  @JsonKey(name: 'shop')
  double shop;

  @JsonKey(name: 'desc')
  String desc;

  CoinRecord(this.datetime,this.key,this.point,this.shop,this.desc,);

  factory CoinRecord.fromJson(Map<String, dynamic> srcJson) => _$CoinRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CoinRecordToJson(this);

}

  

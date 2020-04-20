import 'package:json_annotation/json_annotation.dart'; 
  
part 'm_record_list.g.dart';


@JsonSerializable()
  class MRecordList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<MRecord> list;

  MRecordList(this.count,this.next,this.list,);

  factory MRecordList.fromJson(Map<String, dynamic> srcJson) => _$MRecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MRecordListToJson(this);

}

  
@JsonSerializable()
  class MRecord extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'expired')
  String expired;

  @JsonKey(name: 'machine')
  String machine;

  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'days')
  int days;

  @JsonKey(name: 'number')
  double number;

  MRecord(this.id,this.created,this.expired,this.machine,this.user,this.days,this.number,);

  factory MRecord.fromJson(Map<String, dynamic> srcJson) => _$MRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MRecordToJson(this);

}

  

import 'package:json_annotation/json_annotation.dart'; 
  
part 'pay_list.g.dart';


@JsonSerializable()
  class PayList extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<Pay> list;

  PayList(this.count,this.next,this.list,);

  factory PayList.fromJson(Map<String, dynamic> srcJson) => _$PayListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayListToJson(this);

}

  
@JsonSerializable()
  class Pay extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type_desc')
  String typeDesc;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'number')
  String number;

  Pay(this.id,this.typeDesc,this.type,this.name,this.number,);

  factory Pay.fromJson(Map<String, dynamic> srcJson) => _$PayFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayToJson(this);

}

  

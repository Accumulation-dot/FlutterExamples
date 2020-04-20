import 'package:json_annotation/json_annotation.dart'; 
  
part 'summary.g.dart';


@JsonSerializable()
  class Summary extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'identified')
  int identified;

  @JsonKey(name: 'bank')
  int bank;

  @JsonKey(name: 'ali')
  int ali;

  @JsonKey(name: 'count')
  double count;

  @JsonKey(name: 'shop')
  double shop;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'address')
  String address;

  Summary(this.id,this.identified,this.bank,this.ali,this.count,this.shop,this.phone,this.created,this.name,this.address,);

  factory Summary.fromJson(Map<String, dynamic> srcJson) => _$SummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);

}

  

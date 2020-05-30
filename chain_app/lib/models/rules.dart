import 'package:json_annotation/json_annotation.dart'; 
  
part 'rules.g.dart';


@JsonSerializable()
  class Rules extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<Rule> list;

  Rules(this.count,this.next,this.list,);

  factory Rules.fromJson(Map<String, dynamic> srcJson) => _$RulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RulesToJson(this);

}

  
@JsonSerializable()
  class Rule extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'min_num')
  double minNum;

  @JsonKey(name: 'tax')
  double tax;

  @JsonKey(name: 'shop')
  double shop;

  @JsonKey(name: 'advert')
  double advert;

  Rule(this.name,this.minNum,this.tax,this.shop,this.advert,);

  factory Rule.fromJson(Map<String, dynamic> srcJson) => _$RuleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RuleToJson(this);

}

  

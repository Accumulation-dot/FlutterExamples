import 'package:json_annotation/json_annotation.dart'; 
  
part 'c_s.g.dart';


@JsonSerializable()
  class CS extends Object {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'wechat')
  String wechat;

  CS(this.content,this.wechat,);

  factory CS.fromJson(Map<String, dynamic> srcJson) => _$CSFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CSToJson(this);

}

  

import 'package:json_annotation/json_annotation.dart'; 
  
part 'app_version.g.dart';


@JsonSerializable()
  class AppVersion extends Object {

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'flag')
  int flag;

  @JsonKey(name: 'app')
  String app;

  AppVersion(this.version,this.flag, this.app);

  factory AppVersion.fromJson(Map<String, dynamic> srcJson) => _$AppVersionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppVersionToJson(this);

}

  

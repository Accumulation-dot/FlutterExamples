import 'package:json_annotation/json_annotation.dart';

part 'cache_config.g.dart';

@JsonSerializable()
class CacheConfig extends Object {
  @JsonKey(name: 'enable')
  bool enable;

  @JsonKey(name: 'maxAge')
  int maxAge;

  @JsonKey(name: 'maxCount')
  int maxCount;

  CacheConfig(
    this.enable,
    this.maxAge,
    this.maxCount,
  );

  factory CacheConfig.fromJson(Map<String, dynamic> srcJson) =>
      _$CacheConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CacheConfigToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'coin')
  double coin;

  @JsonKey(name: 'created')
  String created;

  @JsonKey(name: 'frozen')
  double frozen;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'token')
  String token;

  UserInfo(
    this.coin,
    this.created,
    this.frozen,
    this.address,
    this.token,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

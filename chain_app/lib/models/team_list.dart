import 'package:json_annotation/json_annotation.dart';

part 'team_list.g.dart';

@JsonSerializable()
class TeamList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<Member> list;

  TeamList(
    this.count,
    this.next,
    this.list,
  );

  factory TeamList.fromJson(Map<String, dynamic> srcJson) =>
      _$TeamListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TeamListToJson(this);
}

@JsonSerializable()
class Member extends Object {
  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'date_joined')
  String date_joined;

  Member(
    this.username,this.date_joined,
  );

  factory Member.fromJson(Map<String, dynamic> srcJson) =>
      _$MemberFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

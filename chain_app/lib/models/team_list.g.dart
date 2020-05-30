// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamList _$TeamListFromJson(Map<String, dynamic> json) {
  return TeamList(
    json['count'] as int,
    json['next'] as String,
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Member.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeamListToJson(TeamList instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'list': instance.list,
    };

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    json['username'] as String,
    json['date_joined'] as String,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'username': instance.username,
      'date_joined': instance.date_joined,
    };

import 'package:json_annotation/json_annotation.dart';

part 'task_record_list.g.dart';

@JsonSerializable()
class TaskRecordList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<TaskRecord> list;

  TaskRecordList(
    this.count,
    this.next,
    this.list,
  );

  factory TaskRecordList.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskRecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskRecordListToJson(this);
}

@JsonSerializable()
class TaskRecord extends Object {
  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'earn')
  double earn;

  TaskRecord(
    this.user,
    this.date,
    this.earn,
  );

  factory TaskRecord.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskRecordToJson(this);
}

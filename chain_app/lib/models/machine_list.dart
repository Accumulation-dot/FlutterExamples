import 'package:json_annotation/json_annotation.dart';

part 'machine_list.g.dart';

@JsonSerializable()
class MachineList extends Object {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'next')
  String next;

  @JsonKey(name: 'list')
  List<Machine> list;

  MachineList(
    this.count,
    this.next,
    this.list,
  );

  factory MachineList.fromJson(Map<String, dynamic> srcJson) =>
      _$MachineListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MachineListToJson(this);
}

@JsonSerializable()
class Machine extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'days')
  int days;

  @JsonKey(name: 'number')
  double number;

  @JsonKey(name: 'append')
  int append;

  @JsonKey(name: 'cost')
  double cost;

  @JsonKey(name: 's_no')
  String sNo;

  @JsonKey(name: 'max_count')
  int maxCount;

  @JsonKey(name: 'given')
  bool given;
  Machine(
    this.id,
    this.title,
    this.count,
    this.days,
    this.number,
    this.append,
    this.cost,
    this.sNo,
    this.maxCount,
    this.given,
  );

  factory Machine.fromJson(Map<String, dynamic> srcJson) =>
      _$MachineFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MachineToJson(this);
}

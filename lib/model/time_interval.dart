import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_interval.g.dart';

@JsonSerializable()
class TimeInterval extends Equatable{
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'motoDrivers')
  final int motoDrivers;

  const TimeInterval({required this.id, required this.start, required this.end, required this.motoDrivers});

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$TimeIntervalToJson(this);

  TimeInterval copyWith({DateTime? start, DateTime? end, int? motoDrivers}) {
    return TimeInterval(id: id, start: start ?? this.start, end: end ?? this.end,
        motoDrivers: motoDrivers ?? this.motoDrivers);
  }

  @override
  List<Object?> get props => [id, start, end, motoDrivers];
}

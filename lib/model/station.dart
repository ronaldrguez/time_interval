
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_interval/model/time_interval.dart';
import 'package:time_interval/model/user.dart';

part 'station.g.dart';

@JsonSerializable()
class Station extends Equatable{
  @JsonKey(name: 'users')
  final List<User> users;
  @JsonKey(name: 'intervals')
  final List<TimeInterval> intervals;

  const Station({this.users = const [], this.intervals = const []});

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);

  Station copyWith({List<User>? users, List<TimeInterval>? intervals,}) {
    return Station(users: users ?? this.users, intervals: intervals ?? this.intervals,);
  }

  @override
  List<Object?> get props => [users, intervals];
}
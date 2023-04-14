import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable{
  @JsonKey(name: 'userName')
  final String userName;
  @JsonKey(name: 'intervals')
  final List<int> intervals;

  const User({required this.userName, this.intervals = const []});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({String? userName, List<int>? intervals,}) {
    return User(userName: userName ?? this.userName, intervals: intervals ?? this.intervals,);
  }

  @override
  List<Object?> get props => [userName, intervals];
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      intervals: (json['intervals'] as List<dynamic>)
          .map((e) => TimeInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'users': instance.users,
      'intervals': instance.intervals,
    };

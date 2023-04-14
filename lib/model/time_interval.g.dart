// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) => TimeInterval(
      id: json['id'] as int,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      motoDrivers: json['motoDrivers'] as int,
    );

Map<String, dynamic> _$TimeIntervalToJson(TimeInterval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'motoDrivers': instance.motoDrivers,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String,
      intervals: (json['intervals'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'intervals': instance.intervals,
    };

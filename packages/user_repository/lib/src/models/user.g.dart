// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['userId'] as String,
      authDate: json['authDate'] as String,
      lastScore: json['lastScore'] as int,
      fullName: json['name'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.id,
      'authDate': instance.authDate,
      'lastScore': instance.lastScore,
      'name': instance.fullName,
      'userName': instance.userName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MUsers _$MUsersFromJson(Map<String, dynamic> json) {
  return MUsers()
    ..lst = (json['records'] as List)
        ?.map(
            (e) => e == null ? null : MUser.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MUsersToJson(MUsers instance) => <String, dynamic>{
      'records': instance.lst,
    };

MUser _$MUserFromJson(Map<String, dynamic> json) {
  return MUser()
    ..id = json['ID'] as int
    ..userid = json['USERID'] as String
    ..username = json['USERNAME'] as String
    ..password = json['PASSWORD'] as String;
}

Map<String, dynamic> _$MUserToJson(MUser instance) => <String, dynamic>{
      'ID': instance.id,
      'USERID': instance.userid,
      'USERNAME': instance.username,
      'PASSWORD': instance.password,
    };

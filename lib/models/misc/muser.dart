import 'package:json_annotation/json_annotation.dart';

part 'muser.g.dart';

@JsonSerializable()
class MUsers {
  @JsonKey(name: 'records')
  List<MUser> lst = [];

  MUsers();

  factory MUsers.fromJson(Map<String, dynamic> json) => _$MUsersFromJson(json);

  Map<String, dynamic> toJson() => _$MUsersToJson(this);
}

@JsonSerializable()
class MUser {
  @JsonKey(name: 'ID', includeFromJson: true, includeToJson: false)
  var id = 0;
  @JsonKey(name: 'USERID')
  var userid = "";
  @JsonKey(name: 'USERNAME')
  var username = "";
  @JsonKey(name: 'PASSWORD')
  var password = "";

  MUser();

  factory MUser.fromJson(Map<String, dynamic> json) => _$MUserFromJson(json);

  Map<String, dynamic> toJson() => _$MUserToJson(this);
}

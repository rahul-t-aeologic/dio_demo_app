import 'package:dio_demo_app/model/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponse {
  UserResponse({
    required this.data,
  });

  UserDataModel? data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
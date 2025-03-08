import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart'; // This is the generated file

@JsonSerializable()
class EditProfileRequest {
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  EditProfileRequest({
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);

  // Generate the `fromJson` method
  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);
}
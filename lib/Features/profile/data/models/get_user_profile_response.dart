
/// message : "success"
/// user : {"_id":"67b6325886a024f06ea284ec","username":"abdelrmman","firstName":"Abdo","lastName":"Abdo","email":"abdelrhmansaeedx@gmail.com","phone":"01025433520","role":"user","isVerified":false,"createdAt":"2025-02-19T19:34:48.558Z"}

class GetUserProfileResponse {
  GetUserProfileResponse({
      this.message, 
      this.user,});

  GetUserProfileResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserProfile.fromJson(json['user']) : null;
  }
  String? message;
  UserProfile? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}/// _id : "67b6325886a024f06ea284ec"
/// username : "abdelrmman"
/// firstName : "Abdo"
/// lastName : "Abdo"
/// email : "abdelrhmansaeedx@gmail.com"
/// phone : "01025433520"
/// role : "user"
/// isVerified : false
/// createdAt : "2025-02-19T19:34:48.558Z"

class UserProfile {
  UserProfile({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,});

  UserProfile.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['isVerified'] = isVerified;
    map['createdAt'] = createdAt;
    return map;
  }

}
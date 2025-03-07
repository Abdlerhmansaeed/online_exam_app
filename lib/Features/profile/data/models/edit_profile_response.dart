
/// message : "success"
/// user : {"_id":"67b6325886a024f06ea284ec","username":"abdelrmman","firstName":"Abdo","lastName":"Tech","email":"abdelrhmansaeedx@gmail.com","phone":"01025433520","role":"user","password":"$2b$08$XnnVjn4GMeSy1lMGV2vKMOeYIb6dBYxiOg05KAPK2cqpjG9Eq60tq","isVerified":false,"createdAt":"2025-02-19T19:34:48.558Z","passwordChangedAt":"2025-03-02T11:50:37.734Z"}

class EditProfileResponse {
  EditProfileResponse({
      this.message, 
      this.user,});

  EditProfileResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? EditUser.fromJson(json['user']) : null;
  }
  String? message;
  EditUser? user;

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
/// lastName : "Tech"
/// email : "abdelrhmansaeedx@gmail.com"
/// phone : "01025433520"
/// role : "user"
/// password : "$2b$08$XnnVjn4GMeSy1lMGV2vKMOeYIb6dBYxiOg05KAPK2cqpjG9Eq60tq"
/// isVerified : false
/// createdAt : "2025-02-19T19:34:48.558Z"
/// passwordChangedAt : "2025-03-02T11:50:37.734Z"

class EditUser {
  EditUser({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.password,
    this.isVerified,
    this.createdAt,
    this.passwordChangedAt,});

  EditUser.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    password = json['password'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    passwordChangedAt = json['passwordChangedAt'];
  }
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? password;
  bool? isVerified;
  String? createdAt;
  String? passwordChangedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['password'] = password;
    map['isVerified'] = isVerified;
    map['createdAt'] = createdAt;
    map['passwordChangedAt'] = passwordChangedAt;
    return map;
  }

}
class EditProfileRequest {
   String ?userName;
   String ?firstName;
   String ?lastName;
   String ?email;
   String ?phone;

  EditProfileRequest({this.userName, this.firstName, this.lastName, this.email, this.phone});
  Map<String, dynamic> toJson() => {
    "username": userName,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,

  };
}

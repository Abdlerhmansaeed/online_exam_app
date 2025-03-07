class ChangePasswordRequest {
  final String oldPassword;
  final String password;
  final String rePassword;


  ChangePasswordRequest(this.oldPassword, this.password, this.rePassword);
  Map<String, dynamic> toJson() => {
    "oldPassword": oldPassword,
    "password": password,
    "rePassword": rePassword,


  };
}

/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YjYzMjU4ODZhMDI0ZjA2ZWEyODRlYyIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzQwOTE2MjM3fQ.o2q_u6l4P5d4hSbMo2Z4VNRsZG68ARG6B7EysYOei48"

class ChangePasswordResponse {
  ChangePasswordResponse({
      this.message, 
      this.token,});

  ChangePasswordResponse.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}
class SignupResponseModel {
  final String token;
  final String error;
  final String userId;

  SignupResponseModel({required this.token, required this.error, required this.userId});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
      userId: json["userId"] != null ? json["userId"] : "",

     

    );
  }
    void printAttributes() {
    print("id: ${this.userId}\n");
   
    print("token: ${this.token}\n");
  }
}

class SignupRequestModel {
  String ?email;
  String ?phone;
  String ?password;
  int ?permission;


  SignupRequestModel({
     this.email,
     this.phone,
     this.password,
     this.permission

  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'phone' : phone,
      'password': password?.trim(),
      'permission' : permission
    };

    return map;
  }
 
}

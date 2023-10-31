class SigninResponseModel {
  final String token;
  final String error;

  SigninResponseModel({required this.token, required this.error});

  factory SigninResponseModel.fromJson(Map<String, dynamic> json) {
    return SigninResponseModel(
      token: json["userId"] != null ? json["userId"] : "",
      error: json["error"] != null ? json["error"] : "",

    );
  }
}

class SigninRequestModel {
  String ?email;
  String ?password;
  
  SigninRequestModel({
     this.email,
     this.password,
    
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
     
    };

    return map;
  }
}

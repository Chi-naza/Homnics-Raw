import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_api.dart';

class User {
  String id;
  String email;
  String phone;
  String password;
  int permission;
  String token;
  String firstName;
  String lastName;
  String? fullName;
  String address;
  String? avatar;
  bool? isActive;
  String? identityDocument;
  String? professionalLicence;
  List<String?>? permissions;
  String emergencyContactName;
  String emergencyContactPhone;
  String city;
  String state;
  String country;
  String postalCode;
  String gender;
  String emergencyContactRelationship;
  String dateOfBirth;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.dateOfBirth,
    this.permission = 1100,
    this.token = '',
    required this.firstName,
    required this.lastName,
    this.fullName,
    this.avatar,
    this.isActive,
    this.identityDocument,
    this.professionalLicence,
    this.permissions,
    required this.gender,
    required this.emergencyContactRelationship,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'] ?? '',
      permission: (json['permissions'])?.contains('User') ? 1100 : 0,
      token: json['token'] ?? '',
      address: json['address'].toString(),
      emergencyContactName: json['emergencyContactName'].toString(),
      emergencyContactPhone: json['emergencyContactPhone'].toString(),
      city: json['city'].toString(),
      state: json['state'].toString(),
      country: json['country'].toString(),
      postalCode: json['postalCode'].toString(),
      //dateOfBirth: json['dateOfBirth'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      fullName: json['fullName']?.toString(),
      avatar: json['avatar']?.toString(),
      isActive: json['isActive'],
      identityDocument: json['identityDocument']?.toString(),
      professionalLicence: json['professionalLicence']?.toString(),
      gender: json['gender'].toString(),
      dateOfBirth: json['dateOfBirth'].toString(),
      emergencyContactRelationship:
          json['emergencyContactRelationship'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
      'phone': phone.trim(),
      'permission': permission,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'dateOfBirth': dateOfBirth,
      'fullName': fullName ?? '',
      'avatar': avatar ?? '',
      'isActive': isActive ?? '',
      'identityDocument': identityDocument ?? '',
      'professionalLicence': professionalLicence ?? '',
      'gender': gender,
      'emergencyContactRelationship': emergencyContactRelationship,
    };

    return map;
  }

  static updatelocalUser(User user) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String id = (user.id);
    print('id is $id');
    id.isNotEmpty ? await _pref.setString("user_id", id) : null;
    await _pref.setString("user_email", user.email);
    await _pref.setString("user_password", user.password);
    await _pref.setString("user_token", user.token);
  }

  static Future<(String, String, String, String)> getLocalUserData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String id = await _pref.getString("user_id") ?? '';
    String email = _pref.getString("user_email") ?? '';
    String password = _pref.getString("user_password") ?? '';
    String token = await _pref.getString("user_token") ?? '';

    return (id, email, password, token);
  }

  static getById(String userId) async {
    User user = User(
      id: '',
      email: '',
      phone: '',
      password: '',
      firstName: '',
      lastName: '',
      address: '',
      emergencyContactName: '',
      emergencyContactPhone: '',
      city: '',
      state: '',
      country: '',
      postalCode: '',
      gender: '',
      emergencyContactRelationship: '',
      dateOfBirth: '',
      avatar: '',
    ); //added
    try {
      user = await AuthAPI().getUserById(userId);
    } catch (error) {
      print(error.toString());
    } finally {
      return user;
    }
  }

  static getCurrentLoggedInUser() async {
    try {
      User user = await AuthAPI().getCurrentUser();
      await updatelocalUser(user);
      return user;
    } catch (error) {
      print("GET Currently LoggedIn User Error" + error.toString());
    }
  }
  
}

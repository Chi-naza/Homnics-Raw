import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/Subscription/benefitiary_list.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';
import 'package:http/http.dart' as http;
import '../../../services/base_api.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/controller/authentication_controller.dart';
import '../auth/user_auth/controllers/progressHUD.dart';
import 'api/benefitiaryApi.dart';
import 'api/benefitiary_model.dart';
import 'api/create_beneficiary_request_model.dart';

class NewBeneficiaryScreen extends StatefulWidget {
  final Map? addedBenefitiary;
  final String? userPlanId; // Added this line
  NewBeneficiaryScreen({super.key, this.addedBenefitiary, this.userPlanId});

  @override
  State<NewBeneficiaryScreen> createState() => _NewBeneficiaryScreenState();
}

class _NewBeneficiaryScreenState extends State<NewBeneficiaryScreen> {
  // plan controller
  var userPlanController = Get.find<UsersPlanController>();

  final _globalKey = GlobalKey<FormState>();
  BenefitiaryRequestModel benefitiaryRequestModel = BenefitiaryRequestModel();
  BenefitiaryController beneficiaryController = BenefitiaryController();
  var authenticationController = Get.find<AuthenticationController>();

  bool isApiCallProcess = false;
  bool _isCheck = false;
  String? fName;
  String userId = '';
  String networkImage =
      'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg';
  String savedDate = 'D.O.B';
  File? _imageUrl;
  DateTime? selectedDate;
  ImagePicker imagePicker = ImagePicker();
  List<Map<String, dynamic>> genderList = [];
  List<Map<String, dynamic>> relationshipList = [];

  Map<String, dynamic>? selectedGender;
  Map<String, dynamic>? selectedRelationship;

  final String apiUrl = 'https://api.homnics.com/user-api/plan/beneficiary';
  final String email = 'kingshub010@gmail.com';

  bool isEdit = false;

  // User user = User(email: '', phone: '', password: '');
  AuthAPI userAuth = AuthAPI();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  //TextEditingController _emergencyContactRelationshipController = TextEditingController();
  TextEditingController _emergencyContactNumberController =
      TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _surfixController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("W Id :: ${widget.userPlanId}");
    _firstNameController.addListener(onListen);
    _middleNameController.addListener(onListen);
    _lastNameController.addListener(onListen);

    _mobileNumberController.addListener(onListen);
    _addressController.addListener(onListen);

    _stateController.addListener(onListen);
    _cityController.addListener(onListen);
    _countryController.addListener(onListen);
    _emailController.addListener(onListen);
    _zipCodeController.addListener(onListen);
    _surfixController.addListener(onListen);
    // _emergencyContactRelationshipController.addListener(onListen);
    _emergencyContactNumberController.addListener(onListen);

    benefitiaryRequestModel = BenefitiaryRequestModel();
    final addedBenefitiary = widget.addedBenefitiary;
    if (addedBenefitiary != null) {
      isEdit = true;
      final firstName = addedBenefitiary['firstName'];
      final middleName = addedBenefitiary['middleName'];
      final lastName = addedBenefitiary['lastName'];
      final email = addedBenefitiary['email'];
      final phoneNumber = addedBenefitiary['phoneNumber'];
      final surfix = addedBenefitiary['suffix'];
      final address = addedBenefitiary['addressLine1'];
      final city = addedBenefitiary['city'];
      final state = addedBenefitiary['state'];
      final country = addedBenefitiary['country'];
      final zipCode = addedBenefitiary['zipCode'];

      _firstNameController.text = firstName;
      _middleNameController.text = middleName;
      _lastNameController.text = lastName;
      _emailController.text = email;
      _mobileNumberController.text = phoneNumber;
      _surfixController.text = surfix;
      _addressController.text = address;
      _cityController.text = city;
      _stateController.text = state;
      _countryController.text = country;
      _zipCodeController.text = zipCode;
    }
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    // TODO: modularize/break down this widget (it's too long)
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BenefitiaryListScreen()));
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: iconsColor,
            ),
          ),
        ),
        title: Text(
          "New beneficiary",
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                onTap: () {
                                  // getGallery();
                                },
                                child: _imageUrl == null
                                    ? CachedNetworkImage(
                                        imageUrl: networkImage,
                                        imageBuilder: (context, image) =>
                                            CircleAvatar(
                                              backgroundImage: image,
                                              radius: 40,
                                            ))
                                    //  CircleAvatar(
                                    //     radius: 30.0,
                                    //     backgroundImage: NetworkImage(
                                    //       networkImage,
                                    //     ),
                                    //     backgroundColor: Colors.transparent,
                                    //   )
                                    : Image.file(
                                        _imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 2,
                              child: Icon(
                                Icons.add_circle,
                                color: primaryColor,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Text(
                    'Contact info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                        color: secondaryFillColor),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //onSaved: (input) => benefitiaryRequestModel.firstName = input,
                    //onSaved: (input) => updateRequestModel.firstName = input,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText:
                          // updateRequestModel.firstName?.isNotEmpty ?? false
                          //     ? updateRequestModel.firstName!:
                          isEdit ? 'Hello Edit' : 'First name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "First name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _middleNameController,
                    keyboardType: TextInputType.name,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onSaved: (input) => benefitiaryRequestModel.middleName = input,
                    //onSaved: (input) => updateRequestModel.firstName = input,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText:
                          // updateRequestModel.firstName?.isNotEmpty ?? false
                          //     ? updateRequestModel.firstName!:
                          'Middle name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "First name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    //onSaved: (input) => benefitiaryRequestModel.lastName = input,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'Last name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Last name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    //onSaved: (input) => benefitiaryRequestModel.lastName = input,
                    autofillHints: [AutofillHints.email],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Last name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.phone,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onSaved: (input) => benefitiaryRequestModel.phoneNumber = input,
                    autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.phone_android, color: primaryColor),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Number can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _surfixController,
                    keyboardType: TextInputType.text,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    // onSaved: (input) => benefitiaryRequestModel.phoneNumber = input,
                    autofillHints: [AutofillHints.nameSuffix],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.phone_android, color: primaryColor),
                      labelText: 'Surfix',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Number can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 24),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: primaryColor,
                          value: _isCheck,
                          onChanged: (value) {
                            setState(() {
                              _isCheck = value!;
                            });
                          },
                        ),
                        Text('Same as my address'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.multiline,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.name],
                    // onSaved: (input) => benefitiaryRequestModel.addressLine1 = input,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      prefixIcon: Icon(
                        Icons.home_outlined,
                        color: primaryColor,
                        size: 24,
                      ),
                      labelText: 'Residential address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    maxLines: 3,
                    minLines: 2,
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Address can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Container(
                            // width: MediaQuery.of(context).size.width/2.9,
                            height: 40,
                            decoration: BoxDecoration(
                              //color: appBarColor,
                              border: Border.all(
                                color: primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      selectedDate != null
                                          ? '${selectedDate.toString().substring(0, 10)}'
                                          : savedDate,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButtonHideUnderline(
                          child: Container(
                            //width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                              color: appBarColor,
                              border:
                                  Border.all(color: primaryColor, width: 1.3),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<Map<String, dynamic>>(
                              value: selectedGender,
                              hint: Text('Gender',
                                  style: TextStyle(fontSize: 15)),
                              onChanged: (Map<String, dynamic>? newValue) {
                                // setState(() {
                                //   selectedGender = newValue;
                                //   if (newValue != null) {
                                //     benefitiaryRequestModel.gender =
                                //         newValue.values.first.toString();
                                //   } else {
                                //     benefitiaryRequestModel.gender = "empty";
                                //   }
                                // });
                              },
                              items: genderList
                                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                                      (gender) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: gender,
                                  child: Text(gender['name']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _cityController,
                    keyboardType: TextInputType.name,
                    //  onSaved: (input) =>
                    //      _cityController.text = input!,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _stateController,
                    keyboardType: TextInputType.name,
                    //  onSaved: (input) =>
                    //      _stateController.text = input!,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _countryController,
                    keyboardType: TextInputType.name,
                    //  onSaved: (input) =>
                    //      _countryController.text = input!,
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Name can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _zipCodeController,
                    //keyboardType: TextInputType.phone,
                    //  onSaved: (input) =>
                    //      benefitiaryRequestModel.country = input,
                    //autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.phone_android, color: primaryColor),
                      labelText: 'ZipCode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: appBarColor,
                      filled: true,
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) return "Number can't be empty";
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        isEdit
                            ? updateBenefitiary(CreateBeneficiaryRequestModel(
                                userPlanId:
                                    "aa681ba1-bd8e-41b2-3c48-08dbc33bcc51",
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                middleName: _middleNameController.text,
                                suffix: _surfixController.text,
                                gender: 0,
                                dateOfBirth: DateTime.parse("2023-10-30"),
                                addressLine1: _addressController.text,
                                addressLine2: '',
                                city: _cityController.text,
                                state: _stateController.text,
                                zipCode: _zipCodeController.text,
                                phoneNumber: _mobileNumberController.text,
                                email: _emailController.text,
                                country: _countryController.text,
                              ))
                            : beneficiaryController
                                .makePostRequest(CreateBeneficiaryRequestModel(
                                userPlanId:
                                    "aa681ba1-bd8e-41b2-3c48-08dbc33bcc51",
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                middleName: _middleNameController.text,
                                suffix: _surfixController.text,
                                gender: 0,
                                dateOfBirth: DateTime.parse("2023-10-30"),
                                addressLine1: _addressController.text,
                                addressLine2: '',
                                city: _cityController.text,
                                state: _stateController.text,
                                zipCode: _zipCodeController.text,
                                phoneNumber: _mobileNumberController.text,
                                email: _emailController.text,
                                country: _countryController.text,
                              ));
                      },
                      child: isEdit
                          ? Text('update beneficiary')
                          : Text('add beneficiary'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate == null ||
              savedDate.isEmpty ||
              savedDate == 'null' ||
              savedDate == ''
          ? DateTime.now()
          : DateTime.parse(savedDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // updateRequestModel.dateOfBirth =
        //     selectedDate.toString().substring(0, 10);
      });
    }
  }

  // getToken() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   return _pref.getString("user_token") ?? '';
  // }

  Future<void> updateBenefitiary(
      CreateBeneficiaryRequestModel createBeneficiaryRequestModel) async {
    final addedBenefitiary = widget.addedBenefitiary;

    if (addedBenefitiary == null) {
      print('You can not call addedBenefitiary without adding data');
      return;
    }

    final url = Uri.parse('https://api.homnics.com/user-api/plan/beneficiary');
    var payload = json.encode(createBeneficiaryRequestModel.toJson());
    try {
      final response = await http.put(
        url,
        headers: await authenticationController.userHeader(),
        body: payload,
      );

      if (response.statusCode < 400) {
        print('PUT request successful!');
        const snackBar = SnackBar(
          content: Text('Beneficiary updated!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Response: ${response.body}');
        print('Response::: ${response}');
        print('Response Statuse Code ${response.statusCode}');

        final route =
            MaterialPageRoute(builder: (context) => BenefitiaryListScreen());
        Navigator.push(context, route);

        //return BenefitiaryRequestModel.fromJson(jsonDecode(response.body));
      } else {
        const snackBar = SnackBar(
          content: Text('Beneficiary failed to updated!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('PUT request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error making PUT request: $error');
    }

    throw Exception('An error occurred while making the PUT request.');
  }

  Future<Map<String, dynamic>> get newMethod async {
    return {
      'userPlanId': await userPlanController.getActivePlanId(),
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'middleName': _middleNameController.text,
      'suffix': _surfixController.text,
      'gender': 0,
      'dateOfBirth': '',
      'addressLine1': _addressController.text,
      'addressLine2': '',
      'city': _cityController.text,
      'state': _stateController.text,
      'zipCode': _zipCodeController.text,
      'phoneNumber': _mobileNumberController.text,
      'email': _emailController.text,
      'country': _countryController.text,
    };
  }

  Future<Map<String, dynamic>> get updateBenefitairyMethod async {
    return {
      'userPlanId': widget.userPlanId,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'middleName': _middleNameController.text,
      'suffix': _surfixController.text,
      'gender': 0,
      'dateOfBirth': '',
      'addressLine1': _addressController.text,
      'addressLine2': '',
      'city': _cityController.text,
      'state': _stateController.text,
      'zipCode': _zipCodeController.text,
      'phoneNumber': _mobileNumberController.text,
      'email': _emailController.text,
      'country': _countryController.text,
    };
  }
}

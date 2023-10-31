import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/models/update_user_request_model.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';
import 'package:homnics/features/auth/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/controller/authentication_controller.dart';
import '../auth/models/user.dart';
import '../auth/user_auth/controllers/progressHUD.dart';
import '../auth/user_auth/model/update_user_model.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../home/screen/navigation_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _globalKey = GlobalKey<FormState>();
  UpdateRequestModel updateRequestModel = UpdateRequestModel();
  bool isApiCallProcess = false;
  String? fName;
  String userId = '';
  String networkImage =
      'https://ahegel-dump.s3.amazonaws.com/homnics-avatar/default_user.png';
  String savedDate = 'D.O.B';
  File? _imageUrl;
  DateTime? selectedDate;
  int selectedGenderId = 0;
  int selectedRelationshipId = 0;
  ImagePicker imagePicker = ImagePicker();
  List<Map<String, dynamic>> genderList = [];
  List<Map<String, dynamic>> relationshipList = [];

  Map<String, dynamic>? selectedGender;
  Map<String, dynamic>? selectedRelationship;
  bool userDataLoaded = false;

  var authenticationController = Get.find<AuthenticationController>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _emergencyContactNameController =
      TextEditingController();
  TextEditingController _cityController = TextEditingController();
  //TextEditingController _emergencyContactRelationshipController = TextEditingController();
  TextEditingController _emergencyContactNumberController =
      TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(onListen);
    _lastNameController.addListener(onListen);

    _mobileNumberController.addListener(onListen);
    _addressController.addListener(onListen);
    _dateOfBirthController.addListener(onListen);
    _cityController.addListener(onListen);
    _stateController.addListener(onListen);
    _countryController.addListener(onListen);
    _emergencyContactNameController.addListener(onListen);
    // _emergencyContactRelationshipController.addListener(onListen);
    _emergencyContactNumberController.addListener(onListen);

    updateRequestModel = UpdateRequestModel();

    fetchGenderList();
    fetchRelationshipList();
    getUserProfileData();

    //_getUserProfile();
  }

  @override
  void dispose() {
    _firstNameController.removeListener(onListen);
    _firstNameController.dispose();
    _lastNameController.removeListener(onListen);
    _lastNameController.dispose();

    _mobileNumberController.removeListener(onListen);
    _mobileNumberController.dispose();
    _addressController.removeListener(onListen);
    _addressController.dispose();
    _cityController.removeListener(onListen);
    _cityController.dispose();
    _stateController.removeListener(onListen);
    _stateController.dispose();
    _countryController.removeListener(onListen);
    _countryController.dispose();
    _dateOfBirthController.removeListener(onListen);
    _dateOfBirthController.dispose();
    _emergencyContactNameController.removeListener(onListen);
    _emergencyContactNameController.dispose();
    _emergencyContactNumberController.removeListener(onListen);
    _emergencyContactNumberController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    authenticationController.getCurrentLoggedInUser();
    // TODO: modularize/break down this widget (it's too long)
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        // backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            //color: iconsColor,
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            // color: textColor,
            fontSize: 20,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.white,
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
                                  getGallery();
                                },
                                child: _imageUrl == null
                                    ? CachedNetworkImage(
                                        imageUrl: '$networkImage',
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 40,
                                        ),
                                        imageBuilder: (context, image) =>
                                            CircleAvatar(
                                          backgroundImage: image,
                                          radius: 40,
                                        ),
                                        errorWidget: (context, image, error) =>
                                            CircleAvatar(
                                          child: Image.network(
                                              'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg'),
                                          radius: 50,
                                        ),
                                      )
                                    // CircleAvatar(
                                    //     radius: 30.0,
                                    //     backgroundImage:
                                    //      CachedNetworkImageProvider(
                                    //       networkImage
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
                      //color: secondaryFillColor
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //onSaved: (input) => signinRequestModel.email = input,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'First name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "First name can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
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
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Last name can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
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
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Number can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _cityController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.location_city, color: primaryColor),
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "City can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _stateController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon: Icon(Icons.location_on, color: primaryColor),
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "State can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _countryController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon: Icon(Icons.location_searching_outlined,
                          color: primaryColor),
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "country can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.phone_android, color: primaryColor),
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Postal Code can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.name],
                    onSaved: (input) {},
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
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    maxLines: 3,
                    minLines: 2,
                    validator: (value) {
                      if (value!.isEmpty) return "Address can't be empty";
                      return null;
                    },
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
                          width: 5,
                        ),

                        //Map<String, dynamic>? selectedGender;
                        DropdownButtonHideUnderline(
                          child: Container(
                            //width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                              // color: appBarColor,
                              border:
                                  Border.all(color: primaryColor, width: 1.3),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<Map<String, dynamic>>(
                              value: selectedGender,
                              hint: Text('Select a gender',
                                  style: TextStyle(fontSize: 15)),
                              onChanged: (Map<String, dynamic>? newValue) {
                                setState(() {
                                  selectedGender = newValue;
                                  selectedGenderId = selectedGender?["id"];
                                  print('Selected Gender: ${selectedGenderId}');
                                  if (newValue != null) {
                                    // print(
                                    //     'Selected Gender: ${newValue['id']}'); // Print the selected gender
                                  }
                                });
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
                  Text(
                    'Emergency Contact Info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w400,
                      //color: secondaryFillColor
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emergencyContactNameController,
                    keyboardType: TextInputType.name,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.name],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.person_outline, color: primaryColor),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Name can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonHideUnderline(
                    child: Container(
                        //width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          //color: appBarColor,
                          border: Border.all(color: primaryColor, width: 1.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            IconTheme(
                              data: IconThemeData(color: primaryColor),
                              child: Icon(Icons.family_restroom),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: DropdownButton<Map<String, dynamic>>(
                                elevation: 0,
                                value: selectedRelationship,
                                hint: Text('Select relationship',
                                    style: TextStyle(fontSize: 15)),
                                onChanged: (Map<String, dynamic>? newValue) {
                                  setState(() {
                                    selectedRelationship = newValue;
                                    selectedRelationshipId =
                                        selectedRelationship?["id"];
                                    print(
                                        "Selected relationship: ${selectedRelationshipId}");
                                  });
                                },
                                items: relationshipList.map<
                                        DropdownMenuItem<Map<String, dynamic>>>(
                                    (relationship) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: relationship,
                                    child: Text(relationship['name']),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emergencyContactNumberController,
                    keyboardType: TextInputType.phone,
                    onSaved: (input) {},
                    autofillHints: [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      prefixIcon:
                          Icon(Icons.phone_android, color: primaryColor),
                      labelText: 'Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //fillColor: appBarColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Number can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(color: primaryColor),
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () => saveProfile(context),
                      child: const Text('Update Profile'),
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

  Future<void> saveProfile(BuildContext context) async {
    //_globalKey.currentState!.validate()
    setState(() {
      isApiCallProcess = true;
    });

    var (userId, email, password, token) =
        await authenticationController.fetchUserData();
    DateTime parsedDate =
        DateTime.parse(selectedDate.toString().substring(0, 10));

    await authenticationController.updateUserInformation(UpdateUserRequestModel(
        userId: userId,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _mobileNumberController.text,
        address: _addressController.text,
        city: _cityController.text,
        country: _countryController.text,
        postalCode: _postalCodeController.text,
        state: _stateController.text,
        dateOfBirth: parsedDate,
        gender: selectedGenderId,
        emergencyContactName: _emergencyContactNameController.text,
        emergencyContactPhone: _emergencyContactNumberController.text,
        emergencyContactRelationship: selectedRelationshipId));
    setState(() {
      isApiCallProcess = false;
    });
  }

  getCam() async {
    var img = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imageUrl = File(img!.path);
    });
  }

  getGallery() async {
    var img = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (img != null) {
        _imageUrl = File(img.path);
      }
    });

    if (img != null) {
      await AuthController.saveAvatar(userId, File(img.path));
    }
  }

  Future<void> fetchGenderList() async {
    final url =
        'https://api.homnics.com/user-api/account/gender-list'; // TODO: Move url to constants

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          genderList.clear(); // Clear the list before adding options
          genderList
              .add({'id': -1, 'name': 'Select a gender'}); // Default option
          genderList
              .addAll(List<Map<String, dynamic>>.from(responseData['genders']));
        });

        SharedPreferences _pref = await SharedPreferences.getInstance();
        var genderVal = _pref.getString('gender') ?? '';

        var gList = List<Map<String, dynamic>>.from(responseData['genders']);

        if (genderVal != '' &&
            genderVal.isNotEmpty &&
            genderVal != 'null' &&
            gList.length > 0) {
          var genderMap =
              gList.firstWhere((gender) => gender['name'] == genderVal);
          selectedGender = genderMap;
          updateRequestModel.gender = selectedGender?['id'].toString();
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchRelationshipList() async {
    final url =
        'https://api.homnics.com/user-api/account/relationship-list'; // TODO: Move url to constants

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          relationshipList.clear(); // Clear the list before adding options
          relationshipList.add(
              {'id': -1, 'name': 'Select a relationship'}); // Default option
          relationshipList.addAll(
              List<Map<String, dynamic>>.from(responseData['relationships']));
        });

        SharedPreferences _pref = await SharedPreferences.getInstance();
        var emergencyContactRelationship =
            _pref.getString('emergencyContactRelationship') ?? '';
        var relList =
            List<Map<String, dynamic>>.from(responseData['relationships']);

        if (emergencyContactRelationship != '' &&
            emergencyContactRelationship.isNotEmpty &&
            emergencyContactRelationship != 'null' &&
            relList.length > 0) {
          var relationshipMap = relList
              .firstWhere((rel) => rel['name'] == emergencyContactRelationship);
          selectedRelationship = relationshipMap;
          updateRequestModel.emergencyContactRelationship =
              selectedRelationship?['id'].toString();
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error: $error');
    }
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
      });
    }
  }

  void getUserProfileData() async {
    // Retrieve the user's data, for example, from your authentication controller
    var userData = await authenticationController.getCurrentLoggedInUser();

    if (userData != null) {
      // User data exists
      setState(() {
        _firstNameController.text = userData.firstName;
        _lastNameController.text = userData.lastName;
        _mobileNumberController.text = userData.phone;
        _cityController.text = userData.city;
        _stateController.text = userData.state;
        _countryController.text = userData.country;
        _postalCodeController.text = userData.postalCode;
        _addressController.text = userData.address;
        _dateOfBirthController.text = userData.dateOfBirth as String;
        // selectedGenderId = userData.gender.to;
        _emergencyContactNameController.text = userData.emergencyContactName;
        // selectedRelationshipId = userData.emergencyContactRelationship;
        _emergencyContactNumberController.text = userData.emergencyContactPhone;
        // Update other controllers with relevant data
        userDataLoaded = true;
      });
    } else {
      // User data doesn't exist (new user)
      userDataLoaded = false;
    }
  }

  // Future<void> _getUserProfile() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();

  //   var user = User(
  //     id: _pref.getString('user_id') ?? '',
  //     email: '',
  //     phone: _pref.getString('user_phone') ?? '',
  //     password: '',
  //     address: _pref.getString('address') ?? '',
  //     emergencyContactName: _pref.getString('emergencyContactName') ?? '',
  //     emergencyContactPhone: _pref.getString('emergencyContactPhone') ?? '',
  //     city: _pref.getString('city') ?? '',
  //     state: _pref.getString('state') ?? '',
  //     country: _pref.getString('country') ?? '',
  //     postalCode: _pref.getString('postalCode') ?? '',
  //     dateOfBirth: _pref.getString('dateOfBirth') ?? '',
  //     firstName: _pref.getString('user_firstname') ?? '',
  //     lastName: _pref.getString('user_lastname') ?? '',
  //     gender: _pref.getString('gender') ?? '',
  //     emergencyContactRelationship:
  //         _pref.getString('emergencyContactRelationship') ?? '',
  //     avatar: _pref.getString('avatar') ?? '',
  //   );

  //   userId = user.id;

  //   var firstName = _pref.getString('user_firstname') ?? '';
  //   var lastName = _pref.getString('user_lastname') ?? '';
  //   var phone = _pref.getString('user_phone') ?? '';

  //   if (firstName != '' && firstName.isNotEmpty && firstName != 'null') {
  //     _firstNameController.text = firstName;
  //   }

  //   print(lastName);
  //   if (lastName != '' && lastName.isNotEmpty && lastName != 'null') {
  //     _lastNameController.text = lastName;
  //   }

  //   if (phone != '' && phone.isNotEmpty && phone != 'null') {
  //     _mobileNumberController.text = phone;
  //   }

  //   if (user.country != '' &&
  //       user.country.isNotEmpty &&
  //       user.country != 'null') {
  //     _countryController.text = user.country;
  //   }

  //   if (user.address != '' &&
  //       user.address.isNotEmpty &&
  //       user.address != 'null') {
  //     _addressController.text = user.address;
  //   }

  //   if (user.dateOfBirth != '' &&
  //       user.dateOfBirth.isNotEmpty &&
  //       user.dateOfBirth != 'null') {
  //     _dateOfBirthController.text = user.dateOfBirth;
  //     savedDate = user.dateOfBirth.split('T')[0];
  //     updateRequestModel.dateOfBirth = savedDate;
  //   }

  //   if (user.emergencyContactName != '' &&
  //       user.emergencyContactName.isNotEmpty &&
  //       user.emergencyContactName != 'null') {
  //     _emergencyContactNameController.text = user.emergencyContactName;
  //   }

  //   if (user.city != '' && user.city.isNotEmpty && user.city != 'null') {
  //     _cityController.text = user.city;
  //   }

  //   if (user.emergencyContactPhone != '' &&
  //       user.emergencyContactPhone.isNotEmpty &&
  //       user.emergencyContactPhone != 'null') {
  //     _emergencyContactNumberController.text = user.emergencyContactPhone;
  //   }

  //   if (user.state != '' && user.state.isNotEmpty && user.state != 'null') {
  //     _stateController.text = user.state;
  //   }

  //   if (user.postalCode != '' &&
  //       user.postalCode.isNotEmpty &&
  //       user.postalCode != 'null') {
  //     _postalCodeController.text = user.postalCode;
  //   }

  //   if (user.avatar != null && user.avatar != '' && user.avatar != 'null') {
  //     setState(() {
  //       networkImage = user.avatar.toString();
  //     });
  //   }
  // }
}

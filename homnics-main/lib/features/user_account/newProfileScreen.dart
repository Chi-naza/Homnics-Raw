import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/utils/colors.dart';
import '../auth/models/user.dart';
import 'package:http_parser/http_parser.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  DateTime? selectedDate;
  String? _uploadResponse;
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
    emergencyContactRelationship: '',
    gender: '',
    dateOfBirth: '',
  );

  File? _imageFile;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getuser();
  }

//  Future<void> _uploadUserImage() async {
//     if (_imageFile == null) {
//       // No image selected
//       return;
//     }

//      final url = 'https://api.homnics.com/user-api/account/${user.id}/avatar';
//     final request = http.MultipartRequest('POST', Uri.parse(url));
//     request.headers['accept'] = '*/*';
//     request.headers['Content-Type'] = 'multipart/form-data';
//     request.files.add(
//       await http.MultipartFile.fromPath('file', _imageFile!.path, contentType: MediaType('application', 'pdf')),
//     );
//     try {
//       final response = await request.send();
//       if (response.statusCode == 200) {
//         // Image uploaded successfully
//         setState(() {
//           _uploadResponse = 'Image uploaded successfully';
//         });
//       } else {
//         // Error occurred during image upload
//         setState(() {
//           _uploadResponse = 'Error uploading image: ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       // Error occurred during HTTP request
//       setState(() {
//         _uploadResponse = 'Error uploading image: $e';
//       });
//     }
//   }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString("user_token") ?? '';
  }

  Future<void> _uploadUserImage() async {
    if (_imageFile == null) {
      return;
    }
    String token = await getToken();
    final url = 'https://api.homnics.com/user-api/account/${user.id}/avatar';
    print("::::::::::: ${user.id}");
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath(
        'avatar',
        _imageFile!.path,
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type if necessary
      ),
    );
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Image uploaded successfully
        print("Image Added");
        setState(() {
          _uploadResponse = 'Image uploaded successfully';
        });
      } else {
        print(response.statusCode);
        print("Image Failed");
        // Error occurred during image upload
        setState(() {
          _uploadResponse = 'Error uploading image: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      // Error occurred during HTTP request
      setState(() {
        _uploadResponse = 'Error uploading image: $e';
      });
    }
  }

  // void _uploadImage() async {
  //   if (_imageFile == null) {
  //     print(":::::::::::::::::: Image is not Selected :::::::::::::");
  //     // No image selected
  //     return;
  //   }

  //   // Create a multipart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://api.homnics.com/user-api/account/${user.id}/avatar'),
  //   );

  //   // Attach the image file to the request

  //   var stream = http.ByteStream(_imageFile!.openRead());
  //   var length = await _imageFile!.length();
  //   var multipartFile = http.MultipartFile(
  //     'profile_picture',
  //     stream,
  //     length,
  //     filename: _imageFile!.path.split('/').last,
  //   );
  //   request.files.add(multipartFile);

  //   try {
  //     // Send the request and get the response
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       // Request successful
  //       print('Profile picture uploaded successfully');
  //       // Add logic to handle success response from the backend if needed
  //     } else {
  //       // Request failed
  //       print('Failed to upload profile picture::::Error code: ${response.statusCode}');
  //       print('Printing body of profile picture::: ${await response.stream.bytesToString()}');
  //       // Add logic to handle error response from the backend if needed
  //     }
  //   } catch (e) {
  //     // Error occurred during the request
  //     print('Error uploading profile picture: $e');
  //     // Add logic to handle exceptions if needed
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: CircleAvatar(
              backgroundColor: appBarColor,
              child: Image.asset(
                'assets/images/landing/img.png',
              ),
            ),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Homnics",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_outlined,
                color: iconsColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                print(":::::::::::::::::::::${user.id}:::::::::");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.grid_view_outlined,
                  color: iconsColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                _imageFile == null
                    ? Text('No image selected')
                    : Image.file(_imageFile!),
                ElevatedButton(
                  onPressed: _selectImage,
                  child: Text('Select Image'),
                ),
                ElevatedButton(
                  onPressed: _uploadUserImage,
                  child: Text('Upload Image'),
                ),
                SizedBox(height: 20),
                Text(_uploadResponse ?? ''),
                Text(
                  selectedDate != null
                      ? 'Selected Date: ${selectedDate.toString().substring(0, 10)}'
                      : 'No date selected',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  Future<void> getuser() async {
  //   user = await User.getLocalUser();

  //   print(":::::::::::::::::::::${user.password}");
  //   setState(() {});
  // }
}

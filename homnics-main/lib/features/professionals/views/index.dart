import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/auth/screens/account_success_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:homnics/features/professionals/controllers/professionalController.dart';
import 'package:homnics/features/professionals/models/all_professional_model.dart';
import 'package:homnics/features/professionals/models/professionals.dart';

import '../../appointment/widgets/ecg_loader.dart';
import '../../appointment/widgets/professional_widget.dart';

class ProfessionalScreen extends StatefulWidget {
  static const routeName = '/professionalScreen';

  ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  //List<Professional> professionals = [];
  final TextEditingController searchController = TextEditingController();
  final ProfessionController professionController = ProfessionController();
  String searchQuery = '';
  String networkImage =
      'https://ahegel-dump.s3.amazonaws.com/homnics-avatar/default_user.png';

  @override
  initState() {
    super.initState();
    _getProfessionals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Book Appointment",
            style: TextStyle(
              //color: textColor,
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationScreen()));
              },
              child: Icon(
                Icons.close,
                //color: iconsColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _getProfessionals,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller:
                                searchController, // Use the controller here
                            cursorColor: Colors.grey,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Find Professionals',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery =
                                    value; // Update searchQuery as text changes
                              });
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _getProfessionals();
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 15),
                            // padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.asset(
                              'assets/images/landing/ri_equalizer-line.png',
                              fit: BoxFit.cover,
                            ),
                            width: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'All Professionals',
                    textAlign: TextAlign.center,
                  ),
                ),
                FutureBuilder<List<Professional>>(
                    future: _getProfessionals(),
                    builder:
                        (context, AsyncSnapshot<List<Professional>> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 5),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Professional professional =
                                          snapshot.data![index];
                                      return ProfessionalWidget(
                                          dateSelected: "",
                                          professional: professional);
                                    }),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        );
                      } else if (!snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.7,
                          padding: EdgeInsets.all(21),
                          //replace this with a loading icon
                          // child: new CircularProgressIndicator(),
                          child: Text(
                            "No professional available on this day, choose another date",
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.9,
                          //replace this with a loading icon
                          // child: new CircularProgressIndicator(),
                          child: EcgLoadingWidget(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Professional>> _getProfessionals() async {
    print(widget);
    List<Professional> professionals = await ProfessionController()
        .apiGetAllProfessionalCall(
            pageNumber: 1, pageSize: 1000, searchParam: searchQuery);

    return professionals;
  }

  deleteThisFunction() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AccountSuccessScreen()));
  }
}

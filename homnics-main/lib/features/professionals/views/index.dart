import 'package:flutter/material.dart';
import 'package:homnics/features/auth/screens/account_success_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:homnics/features/professionals/controllers/professionalController.dart';
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
  List<Professional> professionals = [];
  String planBeneficiaryId = '';
  String networkImage =
      'https://ahegel-dump.s3.amazonaws.com/homnics-avatar/default_user.png';

  @override
  initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: Padding(
        //     padding: const EdgeInsets.all(
        //       8.0,
        //     ),
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: Icon(
        //         Icons.arrow_back_ios_new,
        //         //color: iconsColor,
        //       ),
        //     )),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      //flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          cursorColor: Colors.grey,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              //fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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
              FutureBuilder<List<Professional>>(
                  future: _getProfessionals(),
                  builder:
                      (context, AsyncSnapshot<List<Professional>> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'List of Professionals',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Professional professional =
                                          snapshot.data![index];
                                      return ProfessionalWidget(
                                          professional: professional);
                                    }),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.7,
                        //replace this with a loading icon
                        // child: new CircularProgressIndicator(),
                        child: EcgLoadingWidget(),
                      );
                    }
                    ;
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Professional>> _getProfessionals() async {
    print("here");
    List<Professional> professionals = await ProfessionController()
        .getProfessionals(pageNumber: 1, pageSize: 10, searchParam: "");
    return professionals;
  }

  deleteThisFunction() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AccountSuccessScreen()));
  }

  void getData() {
    // planBeneficiaryId = await UserPlanController().getPlanBeneficiarId(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homnics/features/HealthPlans/models/health_plan_model.dart';
import 'package:homnics/features/HealthPlans/views/plan_checkout_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';

import '../controllers/healthplan_api.dart';

class NewUserHealthcare extends StatefulWidget {
  static const routeName = '/new-user-healthcare-screen';

  const NewUserHealthcare({super.key});

  @override
  State<NewUserHealthcare> createState() => _NewUserHealthcareState();
}

class _NewUserHealthcareState extends State<NewUserHealthcare> {
  // List<HealthPlan> _healthplans = [];
  // HealthPlan healthPlan = HealthPlan();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: SvgPicture.asset('assets/images/landing/gift.svg'),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Health Plans',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
            //color: textColor
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationScreen()));
              },
              icon: SvgPicture.asset('assets/images/landing/X.svg'))
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(color: Color(0xFF01232B)),
      ),

      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Try out our one-time health packages below and pick the right one for you and your family.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(),
            ExpansionTile(
              title: Text("Individual Plan"),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<HealthPlan>>(
                        future: getHealthPlans(),
                        builder: (context,
                            AsyncSnapshot<List<HealthPlan>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return Column(
                              children: [
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![0];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![1];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                //replace this with a loading icon
                                child: new CircularProgressIndicator());
                          }
                          ;
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(),
            ExpansionTile(
              title: Text("Family Plan"),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<HealthPlan>>(
                        future: getHealthPlans(),
                        builder: (context,
                            AsyncSnapshot<List<HealthPlan>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return Column(
                              children: [
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![2];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![3];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                //replace this with a loading icon
                                child: new CircularProgressIndicator());
                          }
                          ;
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(),
            ExpansionTile(
              title: Text("Group Plan"),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<HealthPlan>>(
                        future: getHealthPlans(),
                        builder: (context,
                            AsyncSnapshot<List<HealthPlan>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return Column(
                              children: [
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![4];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                //replace this with a loading icon
                                child: new CircularProgressIndicator());
                          }
                          ;
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(),
            ExpansionTile(
              title: Text("Freemium Plan"),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<HealthPlan>>(
                        future: getHealthPlans(),
                        builder: (context,
                            AsyncSnapshot<List<HealthPlan>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            return Column(
                              children: [
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      //snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        HealthPlan healthplan =
                                            snapshot.data![5];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PlanCheckOutScreen(
                                                            healthPlan:
                                                                healthplan,
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(
                                                          healthplan.name ??
                                                              "Plan Name"),
                                                      //snapshot.data!.description.toString()
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // snapshot.data!.price.toString()
                                                        Text(
                                                          healthplan.maxPerson
                                                                  .toString() ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text('per person'),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .extraPersonPrice
                                                            .toString() ??
                                                        ""),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan
                                                            .description ??
                                                        ''),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(healthplan.price
                                                            .toString() ??
                                                        "0"),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            'more benefits'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                //replace this with a loading icon
                                child: new CircularProgressIndicator());
                          }
                          ;
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<HealthPlan>> getHealthPlans() async {
    List<HealthPlan> _healthplans = await HealthPlanApi().gethealthplans();
    _healthplans.forEach((element) {
      print(element.id);
      print(element.description);
    });
    return _healthplans;
  }
}

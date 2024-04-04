import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class Penal extends StatefulWidget {
  const Penal({super.key});
  @override
  State<Penal> createState() => _Penal();
}

class _Penal extends State<Penal> {
  Color _iconButtonColor1 = Colors.black;
  Color _iconButtonColor3 = Colors.black;

  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(children: [
          Align(
            alignment: const AlignmentDirectional(1, -0.4),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 10.0, top: 5.0),
              child: Container(
                width: 55,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x33000000),
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_alarm, size: 35.0),
                      color: _iconButtonColor1,
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 420,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child:   Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: "Enter Stop name here"
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                child: Text("Alarm Sound" ,style: TextStyle(fontSize: 16),)),
                                            const SizedBox(
                                              width: 150,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                            const Expanded(
                                                child: naviSwitch())
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: 300,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                child: Text("Vibration",style: TextStyle(fontSize: 16),)),
                                            const SizedBox(
                                              width: 150,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                            const Expanded(
                                                child: naviSwitch())
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: 300,
                                        color: Colors.grey,
                                      ),
                                      const Text("Radius"),
                                      radiusRange(),
                                      radiusRange(),
                                      radiusRange(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Save destination"),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.history, size: 35.0),
                      color: _iconButtonColor3,
                      onPressed: () {
                        setState(() {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("stoplist").snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Show loading indicator while waiting for data
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (!snapshot.hasData) {
                                      return Text('No data available'); // Handle case where no data is available
                                    }
                                    // Now you can safely access the data
                                    return Column(
                                      children: [
                                        Text("Stop List"),
                                        SizedBox(
                                          height: 300,
                                          width: 350,
                                          child: DraggableScrollableSheet(
                                            initialChildSize: 0.8,
                                            minChildSize: 0.8,
                                            maxChildSize: 1,
                                            builder: (context, ScrollController scrollController) {
                                              return ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data?.docs.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(snapshot.data?.docs[index]["Name"]),
                                                    subtitle: Text(snapshot.data?.docs[index]["date"]),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

class naviSwitch extends StatefulWidget {
  const naviSwitch({super.key});

  @override
  State<naviSwitch> createState() => _naviSwitchState();
}

class _naviSwitchState extends State<naviSwitch> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: switchValue,
      onChanged: (newValue) async {
        setState(() => switchValue = newValue);
      },
      activeColor: Colors.white,
      activeTrackColor: Color(0xFFB4D4FF),
      inactiveTrackColor: Colors.grey,
      inactiveThumbColor: Colors.white,
    );
  }
}



class radiusRange extends StatefulWidget {
  radiusRange({super.key});

  @override
  State<radiusRange> createState() => _radiusRangeState();
}

class _radiusRangeState extends State<radiusRange> {
  double _currentSlideValue  = 5;
  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _currentSlideValue,
        min: 1,
        max: 10,
        divisions: 10,
        activeColor: Colors.blueAccent,
        label: _currentSlideValue.round().toString(),
        onChanged: (double value){
          setState(() {
            _currentSlideValue = value;
          });
        }
    );
  }
}


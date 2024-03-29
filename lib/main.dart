import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'setting.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized () ;
  await Firebase . initializeApp (
    options : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wakeybus Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MyHomePage(),
          '/setting': (context) => const Setting(),
          '/language': (context) => const LanguagePage(),
          '/notification': (context) => const NotificationPage(),
          '/theme': (context) => const ThemePage(),
          '/helpFeedback': (context) => const HelpFeedbackPage(),
          '/aboutUs': (context) => const AboutUsPage(),
          '/sound': (context) => const SoundPage(),
          '/warningDistant': (context) => const WarningDistantPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          MapSample(),
          SearchBarApp(),
        ]
      ),
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 65.0,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: const Offset(3, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all(CircleBorder()),
                            backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                              return const Color(0xFF1E3643); // Button color
                            }),
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, "/Setting",
                            //     arguments: 'Thanat');
                            Navigator.pushNamed(context, '/setting');
                          },
                          child: Icon(
                            Icons.settings,
                            color: Theme.of(context).colorScheme.surface,
                            size: 27.0,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 0.0, top: 0.0),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: SearchAnchor(
                            builder: (BuildContext context, SearchController controller) {
                              return SearchBar(
                                controller: controller,
                                padding:
                                    const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                                onTap: () {
                                  controller.openView();
                                },
                                onChanged: (_) {
                                  controller.openView();
                                },
                                leading: const Icon(Icons.search), // Search Icon
                              );
                            },
                            suggestionsBuilder: (BuildContext context, SearchController controller) {
                              return List<ListTile>.generate(
                                5,
                                (int index) {
                                  final String item = 'item $index';
                                  return ListTile(
                                    title: Text(item),
                                    onTap: () {
                                      setState(
                                        () {
                                          controller.closeView(item);
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 350,
              width: 75,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 15.0, top: 0.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        const Spacer(flex:1),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(3, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all(const CircleBorder()),
                              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).colorScheme.surface;
                                },
                              ), // Background color
                            ),
                            onPressed: () {},
                            child: const Icon(
                              Icons.my_location_sharp,
                              color: Color(0xFF1E3643),
                              size: 25.0,
                            ),
                          ),
                        ),
                        const Spacer(flex:1),
                        Penal()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //StopDetail()
        ],
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition MUICT = CameraPosition(
    target: LatLng(13.79465063169504, 100.3247490794993),
    zoom: 15.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: MUICT,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId("Marker01"),
            position: LatLng(13.79465063169504, 100.3247490794993),
            infoWindow: InfoWindow(
              title: "Marker01",
              snippet: "Your Destination, Your Ways",
            ),
          ),
          Marker(
            markerId: MarkerId("Marker02"),
            position: LatLng(13.79465063169604, 100.3247490794994),
            infoWindow: InfoWindow(
              title: "Marker02",
              snippet: "Your Destinations, My Ways",
            ),
          ),
        },
        zoomControlsEnabled: false,
        compassEnabled: false,
      ),
    );
  }
}

class Penal extends StatefulWidget {
  const Penal({super.key});


  @override
  State<Penal> createState() => _Penal();
}

class _Penal extends State<Penal> {
  Color _iconButtonColor1 = Colors.black;
  bool pinning = false;
  Color _iconButtonColor2 = Colors.black;
  bool listOf = false;
  Color _iconButtonColor3 = Colors.black;
  bool history = false;
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
                height: 250,
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
                        icon: const Icon(Icons.add_chart, size: 35.0),
                        color: _iconButtonColor2,
                        onPressed: () {
                          setState(() {
                            listOf = !listOf;
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
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
                                            builder: (context,
                                                ScrollController scrollController) {
                                              return ListView.builder(
                                                  controller: scrollController,
                                                  itemCount: 10,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return Container(
                                                      child: const Row(
                                                        children: [
                                                          Expanded(
                                                            child: Icon(
                                                              Icons.bus_alert,
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Text('Item')),
                                                          Expanded(
                                                              child: naviSwitch()),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }),
                                      ),
                                    ],
                                  );
                                });
                          });
                        }),
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
                                    builder: (context, snapshot){
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
                                                builder: (context,
                                                    ScrollController scrollController) {
                                                  return ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: snapshot.data?.docs.length,
                                                    itemBuilder: (context, index) {
                                                      return ListTile(
                                                        title: Text(snapshot.data?.docs[index]["Name"]),
                                                        subtitle: Text(snapshot.data?.docs[index]["date"])
                                                      );
                                                    },
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    });
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
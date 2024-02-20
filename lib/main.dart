import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

void main() {
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
          "/Setting": (context) => const Setting(
                data: '',
              ),
        });
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key, required this.data}) : super(key: key);
  final String data;
  final String title = "Setting";

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Section 1'),
            tiles: [
              SettingsTile(
                title: Text("$data phichitphanphong"),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              )
            ],
          ),
        ],
      ),
    );
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
        ],
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
                          Navigator.pushNamed(context, "/Setting", arguments: 'Thanat');
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
            height: 350.0,
            width: 75,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 15.0, top: 25.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
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
                          onPressed: () {
                            Navigator.pushNamed(context, "/Setting", arguments: 'Thanat');
                          },
                          child: const Icon(
                            Icons.my_location,
                            color: Color(0xFF1E3643),
                            size: 25.0,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 25.0),
                      //   child: Container(
                      //     width: 55,
                      //     height: 250.0,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).colorScheme.surface,
                      //       shape: BoxShape.rectangle,
                      //       borderRadius: const BorderRadius.all(Radius.circular(30)),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.2),
                      //           spreadRadius: 0,
                      //           blurRadius: 3,
                      //           offset: const Offset(3, 4),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         const Spacer(),
                      //         IconButton(
                      //           icon: const Icon(Icons.add_alarm_rounded, color: Color(0xFF1E3643), size: 35.0),
                      //           onPressed: () {},
                      //         ),
                      //         const Spacer(),
                      //         IconButton(
                      //           icon: const Icon(Icons.list_alt_rounded, color: Color(0xFF1E3643), size: 35.0),
                      //           onPressed: () {},
                      //         ),
                      //         const Spacer(),
                      //         IconButton(
                      //           icon: const Icon(Icons.history_rounded, color: Color(0xFF1E3643), size: 35.0),
                      //           onPressed: () {},
                      //         ),
                      //         const Spacer(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Penal(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
  Color _iconButtonColor2 = Colors.black;
  Color _iconButtonColor3 = Colors.black;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(children: [
          Align(
            alignment: const AlignmentDirectional(1, -0.5),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 25.0),
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
                  borderRadius: BorderRadius.circular(50),
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
                          _iconButtonColor1 = _iconButtonColor1 == Colors.black
                              ? Colors.orange
                              : Colors.black;
                          _iconButtonColor2 = Colors.black;
                          _iconButtonColor3 = Colors.black;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_chart, size: 35.0),
                      color: _iconButtonColor2,
                      onPressed: () {
                        setState(() {
                          _iconButtonColor2 = _iconButtonColor2 == Colors.black
                              ? Colors.orange
                              : Colors.black;
                          _iconButtonColor1 = Colors.black;
                          _iconButtonColor3 = Colors.black;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.history, size: 35.0),
                      color: _iconButtonColor3,
                      onPressed: () {
                        setState(() {
                          _iconButtonColor3 = _iconButtonColor3 == Colors.black
                              ? Colors.orange
                              : Colors.black;
                          _iconButtonColor1 = Colors.black;
                          _iconButtonColor2 = Colors.black;
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

class ListOfStop extends StatefulWidget {
  const ListOfStop({super.key});

  @override
  State<ListOfStop> createState() => _ListOfStopState();
}

class _ListOfStopState extends State<ListOfStop> {
  bool switchValue1 = true;
  bool switchValue2 = true;
  bool switchValue3 = true;
  bool switchValue4 = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: const AlignmentDirectional(0.0, 1.0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: Container(
            width: 350,
            height: 333,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: Color(0x33000000),
                  offset: Offset(4, 4),
                  spreadRadius: 0,
                )
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            //padding: EdgeInsetsDirectional.fromSTEB(0,0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: Text(
                      'Stop list',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                        child: Icon(
                          Icons.signpost_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      const Text(
                        'Mahidol, Salaya.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Switch.adaptive(
                          value: switchValue1,
                          onChanged: (newValue) async {
                            setState(() => switchValue1 = newValue);
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xFFB4D4FF),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Icon(
                          Icons.signpost_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      const Text(
                        'Mahidol, Salaya.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Switch.adaptive(
                          value: switchValue2,
                          onChanged: (newValue) async {
                            setState(() => switchValue2 = newValue);
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xFFB4D4FF),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Icon(
                          Icons.signpost_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      const Text(
                        'Mahidol, Salaya.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Switch.adaptive(
                          value: switchValue3,
                          onChanged: (newValue) async {
                            setState(() => switchValue3 = newValue);
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xFFB4D4FF),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 300,
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Icon(
                          Icons.signpost_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      const Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Mahidol, Salaya.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Switch.adaptive(
                          value: switchValue4,
                          onChanged: (newValue) async {
                            setState(() => switchValue4 = newValue);
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xFFB4D4FF),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
        zoomControlsEnabled: false,
        compassEnabled: false,
      ),
    );
  }
}

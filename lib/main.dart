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
          Penal(),
          //StopDetail(),
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
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
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
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              return const Color(0xFF1E3643); // Button color
                            }),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/Setting",
                                arguments: 'Thanat');
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
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 0.0, top: 0.0),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: SearchAnchor(
                            builder: (BuildContext context,
                                SearchController controller) {
                              return SearchBar(
                                controller: controller,
                                padding:
                                    const MaterialStatePropertyAll<EdgeInsets>(
                                        EdgeInsets.symmetric(horizontal: 16.0)),
                                onTap: () {
                                  controller.openView();
                                },
                                onChanged: (_) {
                                  controller.openView();
                                },
                                leading:
                                    const Icon(Icons.search), // Search Icon
                              );
                            },
                            suggestionsBuilder: (BuildContext context,
                                SearchController controller) {
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
              height: 75.0,
              width: 75,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, right: 15.0, top: 15.0),
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all(
                                  const CircleBorder()),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).colorScheme.surface;
                                },
                              ), // Background color
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/Setting",
                                  arguments: 'Thanat');
                            },
                            child: const Icon(
                              Icons.pin_drop,
                              color: Color(0xFF1E3643),
                              size: 25.0,
                            ),
                          ),
                        ),
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
        alignment: const AlignmentDirectional(1, -0.5),
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
                        listOf = !listOf;
                        _iconButtonColor2 = _iconButtonColor2 == Colors.black
                            ? Colors.orange
                            : Colors.black;
                        _iconButtonColor1 = Colors.black;
                        _iconButtonColor3 = Colors.black;
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: DraggableScrollableSheet(builder:
                                    (BuildContext context,
                                        ScrollController scrollController) {
                                  return ListView.builder(
                                      controller: scrollController,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        bool switchValue4 = true;
                                        return Row(
                                          children: [
                                            Text('Item'),
                                            Switch.adaptive(
                                              value: switchValue4,
                                              onChanged: (newValue) async {
                                                setState(() =>
                                                    switchValue4 = newValue);
                                              },
                                              activeColor: Colors.white,
                                              activeTrackColor:
                                                  Color(0xFFB4D4FF),
                                              inactiveTrackColor: Colors.grey,
                                              inactiveThumbColor: Colors.white,
                                            )
                                          ],
                                        );
                                      });
                                })
                            );
                          },
                        );
                      });
                    }),
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

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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

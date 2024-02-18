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
    return Column(
      children: [
        SizedBox(
            height: 100.0,
            child: Scaffold(
              backgroundColor: Colors.amber,
              body: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 35.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return const Color(0xFF1E3643);
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return Theme.of(context).colorScheme.surface;
                        }),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/Setting",
                            arguments: 'Thanat');
                      },
                      child: const Icon(Icons.settings),
                    ),
                    Expanded(
                      flex: 2,
                      child: SearchAnchor(
                        builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search), // Search Icon
                          );
                        },
                        suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          return List<ListTile>.generate(5, (int index) {
                            final String item = 'item $index';
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
              height: 250.0,
              width: 65,
              child: Scaffold(
                  backgroundColor: Colors.green,
                  body: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 8.0, top: 10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white;
                                    }
                                    return null;
                                  }),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    return const Color(0xFF1E3643);
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/Setting",
                                      arguments: 'Thanat');
                                },
                                child: const Icon(Icons.settings),
                              )
                              // Scaffold(
                              //     backgroundColor: Colors.blueGrey
                              // )
                            ],
                          ))))),
        )
      ],
    );
  }
}

// IconButton.filled(
// icon: const Icon(Icons.settings),
// selectedIcon: const Icon(Icons.settings),
// color: const Color(0xFFFFFFFF),
// onPressed: () {
// Navigator.pushNamed(context, "/Setting",
// arguments: 'Thanat');
// },
// ),

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
    zoom: 19,
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

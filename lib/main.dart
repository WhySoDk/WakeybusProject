import 'dart:async';
import 'setting.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'penal.dart';

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
          // "/Setting": (context) => const Setting(
          //       data: '',
          //     ),
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

// class Setting extends StatefulWidget {
//   const Setting({Key? key, required this.data}) : super(key: key);
//   final String data;
//   final String title = "Setting";

//   @override
//   _SettingPageState createState() => _SettingPageState();
// }

// class _SettingPageState extends State<Setting> {
//   @override
//   Widget build(BuildContext context) {
//     final String data = ModalRoute.of(context)!.settings.arguments as String;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SettingsList(
//         sections: [
//           SettingsSection(
//             title: const Text('Section 1'),
//             tiles: [
//               SettingsTile(
//                 title: Text("$data phichitphanphong"),
//                 leading: const Icon(Icons.language),
//                 onPressed: (BuildContext context) {},
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                              // Navigator.pushNamed(context, "/Setting",
                              //     arguments: 'Thanat');
                              Navigator.pushNamed(context, '/setting');
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

import 'package:flutter/material.dart';

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
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
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
                    setState(() {});
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

import 'package:flutter/material.dart';

class Penal extends StatefulWidget {
  const Penal({super.key});

  @override
  State<Penal> createState() => _Penal();
}

class _Penal extends State<Penal> {
  Color _iconButtonColor1 = Color(0xFF1E3643);
  bool pinning = false;
  Color _iconButtonColor2 = Color(0xFF1E3643);
  bool listOf = false;
  Color _iconButtonColor3 = Color(0xFF1E3643);
  bool history = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(children: [
      Align(
        // alignment: const AlignmentDirectional(1, -0.4),
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
                            return DraggableScrollableSheet(
                                builder: (BuildContext context, ScrollController scrollController) {
                              return ListView.builder(
                                  controller: scrollController,
                                  itemCount: 10,
                                  itemBuilder: (BuildContext context, int index) {
                                    return const Row(
                                      children: [
                                        Icon(
                                          Icons.bus_alert,
                                        ),
                                        Text('Item'),
                                        naviSwitch(),
                                      ],
                                    );
                                  });
                            });
                          },
                        );
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

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OdoData extends StatefulWidget {
  const OdoData({super.key});

  @override
  State<OdoData> createState() => _OdoDataState();
}

class _OdoDataState extends State<OdoData> {
  final supabase = Supabase.instance.client;

  List<bool> headLamp = [false, false, false];
  List<bool> indicator = [false, false, false];
  List<bool> driveMode = [false, false, false];
  double speed = 0;
  double battery = 0;
  double remaingRange = 0;
  double odo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setIntialState();
  }

  void setIntialState() async {
    var data = await supabase.from('data').select('headlamp');
    headLamp[data[0]['headlamp']] = true;

    data = await supabase.from('data').select('indicator');
    indicator[data[0]['indicator']] = true;

    data = await supabase.from('data').select('driveMode');
    driveMode[data[0]['driveMode']] = true;

    data = await supabase.from('data').select('speed');
    speed = data[0]['speed'].toDouble();

    data = await supabase.from('data').select('odo');
    odo = data[0]['odo'].toDouble();

    data = await supabase.from('data').select('rideRange');
    remaingRange = data[0]['rideRange'].toDouble();

    data = await supabase.from('data').select('batteryPercentage');
    battery = data[0]['batteryPercentage'].toDouble();

    setState(() {});
  }

  void changeSilderVal(String key, double value) async {
    await supabase.from('data').update({key: value.round()}).match({'id': 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("HeadLamps"),
              ToggleButtons(
                children: [Text("Off"), Text("On"), Text("Full-beam")],
                isSelected: headLamp,
                onPressed: (index) async {
                  await supabase
                      .from('data')
                      .update({'headlamp': index}).match({'id': 1});
                  setState(() {
                    headLamp[0] = headLamp[1] = headLamp[2] = false;
                    headLamp[index] = true;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Indicator"),
              ToggleButtons(
                children: [Text("hazard light"), Text("Left"), Text("Right")],
                isSelected: indicator,
                onPressed: (index) async {
                  await supabase
                      .from('data')
                      .update({'indicator': index}).match({'id': 1});
                  setState(() {
                    indicator[0] = indicator[1] = indicator[2] = false;
                    indicator[index] = true;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Drive Mode"),
              ToggleButtons(
                children: [Text("Eco"), Text("Sport"), Text("Reverse")],
                isSelected: driveMode,
                onPressed: (index) async {
                  await supabase
                      .from('data')
                      .update({'driveMode': index}).match({'id': 1});
                  setState(() {
                    driveMode[0] = driveMode[1] = driveMode[2] = false;
                    driveMode[index] = true;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Speed"),
                  Row(
                    children: [
                      Text("${speed.round()}"),
                      Slider(
                        value: speed.round().toDouble(),
                        onChanged: (value) {
                          setState(() {
                            speed = value;
                          });
                        },
                        max: 250,
                        onChangeEnd: (value) {
                          changeSilderVal("speed", value);
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Battery Percentage"),
                  Row(
                    children: [
                      Text("${battery.round()}"),
                      Slider(
                          value: battery.round().toDouble(),
                          onChanged: (value) {
                            setState(() {
                              battery = value;
                            });
                          },
                          max: 100,
                          onChangeEnd: (value) {
                            changeSilderVal("batteryPercentage", value);
                          }),
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Remaining Range"),
                  Row(
                    children: [
                      Text("${remaingRange.round()}"),
                      Slider(
                          value: remaingRange.round().toDouble(),
                          onChanged: (value) {
                            setState(() {
                              remaingRange = value;
                            });
                          },
                          max: 250,
                          onChangeEnd: (value) {
                            changeSilderVal("rideRange", value);
                          }),
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Odo"),
                  Row(
                    children: [
                      Text("${odo.round()}"),
                      Slider(
                          value: odo.round().toDouble(),
                          onChanged: (value) {
                            setState(() {
                              odo = value;
                            });
                          },
                          max: 10000,
                          onChangeEnd: (value) {
                            changeSilderVal("odo", value);
                          }),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}

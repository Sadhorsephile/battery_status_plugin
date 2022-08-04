import 'package:flutter/material.dart';

import 'package:battery_status_plugin/battery_status_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _batteryStatusPlugin = BatteryStatusPlugin();

  @override
  void initState() {
    _batteryStatusPlugin.init();
    super.initState();
  }

  @override
  void dispose() {
    _batteryStatusPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: StreamBuilder<int>(
            stream: _batteryStatusPlugin.batteryLvl,
            initialData: 0,
            builder: (context, snapshot) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Battery is: ${snapshot.data}\n'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _batteryStatusPlugin.dispose,
                      child: const Text('dispose'),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

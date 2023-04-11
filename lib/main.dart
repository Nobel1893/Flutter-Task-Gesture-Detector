import 'package:flutter/material.dart';
import 'package:geastures_detector_task/CustomButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomButton(
            key: Key('Login'),
            child: ElevatedButton(
              onPressed: () {
                print('button pressed');
              },
              child: Text('Login'),
            ),
          ),
          CustomButton(
            key: Key('Register'),
            criticalDuration: Duration(seconds: 5),
            onUnOrdinaryCLicksDetected: (int clicks, Duration timeFrame,
                Offset offset, String clickedWidgetId) {
              print('Button exceptional behavior detected');
            },
            child: ElevatedButton(
              onPressed: () {
                print('button pressed');
              },
              child: Text('Register'),
            ),
          )
        ]),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Flutter App')),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  bool _isToggled = false;
  final Shell shell = Shell();
 
  void _toggleGPIO() async {
    String command = _isToggled
        ? 'gpioset -z -c gpiochip4 26=1'
        : 'gpioset -z -c gpiochip4 26=0';
 
    try {
      await shell.run(command);
      print("GPIO command executed: $command");
      await shell.run('killall gpioset');
    } catch (e) {
      print("Error running GPIO command: $e");
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hello, World!'), // Keeping the "Hello, World!" text as requested
        SizedBox(height: 20), // Space between text and button
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isToggled = !_isToggled; // Toggle the state
              _toggleGPIO(); // Run the GPIO command when toggled
            });
          },
          child: Text(_isToggled ? 'ON' : 'OFF'),
        ),
      ],
    );
  }
}

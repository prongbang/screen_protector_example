import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:screen_protector/screen_protector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // define the handler for ui
  void onData(NotificationEvent event) {
    print('notification: ${event.title}');
    if (event.title == "Couldn't capture screenshot") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${event.title}'),
      ));
    }
  }

  Future<void> initPlatformState() async {
    NotificationsListener.initialize();
    // register you event handler in the ui logic.
    NotificationsListener.receivePort?.listen((evt) => onData(evt));
  }

  @override
  void initState() {
    initPlatformState();

    // For iOS only.
    _addListenerPreventScreenshot();

    // For iOS and Android
    _preventScreenshotOn();
    super.initState();
  }

  @override
  void dispose() {
    // For iOS only.
    _removeListenerPreventScreenshot();

    // For iOS and Android
    _preventScreenshotOff();
    super.dispose();
  }

  void _preventScreenshotOn() async =>
      await ScreenProtector.preventScreenshotOn();

  void _preventScreenshotOff() async =>
      await ScreenProtector.preventScreenshotOff();

  void _addListenerPreventScreenshot() async {
    ScreenProtector.addListener(() {
      // Screenshot
      debugPrint('Screenshot:');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Screenshot!'),
      ));
    }, (isCaptured) {
      // Screen Record
      debugPrint('Screen Record:');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Screen Record!'),
      ));
    });
  }

  void _removeListenerPreventScreenshot() async {
    ScreenProtector.removeListener();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

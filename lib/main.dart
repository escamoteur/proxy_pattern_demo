import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/di.dart';
import 'package:proxy_pattern_demo/home_page.dart';
import 'package:watch_it/watch_it.dart';

void main() {
  /// register the dependencies
  initDi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proxy Pattern Demo'),
        ),
        body: FutureBuilder(
            future: di.allReady(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              return const HomePage();
            }),
      ),
    );
  }
}

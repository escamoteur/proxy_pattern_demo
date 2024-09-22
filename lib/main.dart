import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/di.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/home_page.dart';
import 'package:watch_it/watch_it.dart';

void main() {
  /// register the dependencies
  initDi();
  runApp(const MainApp());
}

class MainApp extends WatchingWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool appInitialized = allReady();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proxy Pattern Demo'),
          actions: [
            if (appInitialized)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  di<PostManager>().postsFeed.updateData();
                },
              ),
            const SizedBox(
              width: 64,
            ),
          ],
        ),
        body: appInitialized
            ? const HomePage()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

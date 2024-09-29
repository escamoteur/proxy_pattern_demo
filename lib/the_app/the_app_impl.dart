import 'dart:async';

import 'package:flutter_command/flutter_command.dart';
import 'package:proxy_pattern_demo/the_app/the_app_.dart';

class TheAppImplementation extends TheApp {
  TheAppImplementation() {
    Command.globalExceptionHandler = (e, s) {
      _errorMessages.add(e.error.toString());
    };
  }

  final StreamController<String> _errorMessages =
      StreamController<String>.broadcast();

  @override
  Stream<String> get errorMessagesStream => _errorMessages.stream;
}

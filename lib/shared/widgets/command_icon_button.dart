import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:watch_it/watch_it.dart';

class CommandIconButton extends WatchingWidget {
  const CommandIconButton(
      {required this.command, required this.icon, super.key});

  final Command command;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final canExecute = watch(command.canExecute).value;
    return IconButton(
      onPressed: canExecute ? command.execute : null,
      icon: Icon(icon),
    );
  }
}

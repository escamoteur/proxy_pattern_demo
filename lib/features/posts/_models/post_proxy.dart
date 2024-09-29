import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class PostProxy extends ChangeNotifier {
  PostDto? _target;
  int referenceCount = 0;

  PostProxy(this._target);

  //setter for the target
  set target(PostDto value) {
    _updateTarget(value);
  }

  void _updateTarget(PostDto postDto) {
    _likeOverride = null;
    _target = postDto;
    notifyListeners();
  }

  int get id => _target!.id;
  String get title => _target!.title;
  String get imageUrl => _target!.imageUrl;
  bool get isLiked => _likeOverride ?? _target!.isLiked;
  bool? _likeOverride;

  /// create a combines ValueListenable based on the updateDataCommands  and local updateFromApiCommand
  late ValueListenable<bool> commandRestrions = di<PostManager>()
      .updateFromApiIsExecuting
      .combineLatest(updateFromApiCommand.isExecuting, (a, b) => a || b);

  late final updateFromApiCommand = Command.createAsyncNoParamNoResult(
    () async {
      final postDto = await di<ApiClient>().getPost(_target!.id);
      _updateTarget(postDto);
    },
    // block the command if any updateDataCommand is executing
    restriction: di<PostManager>().updateFromApiIsExecuting,
  );

  late final likeCommand = Command.createAsyncNoParamNoResult(
    () async {
      /// optimistic UI update
      _likeOverride = true;
      notifyListeners();
      await di<ApiClient>().likePost(_target!.id);
    },
    // block the command if we update from the api
    restriction: commandRestrions,
    // we want that the error is handled locally and globally in TheAppImplementation
    errorFilter: const ErrorHandlerLocalAndGlobal(),
  )..errors.listen(
      (e, _) {
        _likeOverride = null;

        notifyListeners();
      },
    );

  late final unlikeCommand = Command.createAsyncNoParamNoResult(
    () async {
      /// optimistic UI update
      _likeOverride = false;
      notifyListeners();
      await di<ApiClient>().unlikePost(_target!.id);
    },
    // block the command if we update from the api
    restriction: commandRestrions,
    errorFilter: const ErrorHandlerLocalAndGlobal(),
  )..errors.listen(
      (e, _) {
        _likeOverride = null;
        notifyListeners();
      },
    );

  @override
  void dispose() {
    /// dispose all Commands
    updateFromApiCommand.dispose();
    likeCommand.dispose();
    unlikeCommand.dispose();
    super.dispose();
  }
}

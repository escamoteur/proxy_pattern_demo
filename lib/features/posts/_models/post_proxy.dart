import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class PostProxy extends ChangeNotifier {
  PostDto _target;
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

  int get id => _target.id;
  String get title => _target.title;
  String get imageUrl => _target.imageUrl;
  bool get isLiked => _likeOverride ?? _target.isLiked;
  // optimistic UI update
  bool? _likeOverride;

  /// create a combined ValueListenable based on the updateDataCommands of
  /// the data sources and local updateFromApiCommand
  late ValueListenable<bool> commandRestrictions = di<PostManager>()
      .updateFromApiIsExecuting
      .combineLatest(updateFromApiCommand.isExecuting, (a, b) => a || b);

  late final updateFromApiCommand = Command.createAsyncNoParamNoResult(
    () async {
      final postDto = await di<ApiClient>().getPost(_target.id);
      _updateTarget(postDto);
    },
    // block the command if any updateDataCommand is executing
    restriction: di<PostManager>().updateFromApiIsExecuting,
  );

  late final toggleLikeCommand = Command.createUndoableNoParamNoResult<bool>(
    (undoStack) async {
      undoStack.push(isLiked);

      /// optimistic UI update

      _likeOverride = !isLiked;
      notifyListeners();
      if (_likeOverride!) {
        await di<ApiClient>().likePost(_target.id);
      } else {
        await di<ApiClient>().unlikePost(_target.id);
      }
    },
    undo: (undoStack, reason) {
      _likeOverride = undoStack.pop();
      notifyListeners();
    },
    // block the command if we update from the api
    restriction: commandRestrictions,
    // we want that the error is handled locally and globally in TheAppImplementation
    errorFilter: const ErrorHandlerGlobalIfNoLocal(),
  );

  @override
  void dispose() {
    /// we have to dispose all Commands because
    /// they contain a lot of ValueNotifiers
    updateFromApiCommand.dispose();
    toggleLikeCommand.dispose();
    super.dispose();
  }
}

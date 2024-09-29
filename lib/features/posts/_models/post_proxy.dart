import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class PostProxy extends ChangeNotifier {
  PostDto? _target;
  int referenceCount = 0;

  PostProxy(this._target);

  //setter for the target
  set target(PostDto value) {
    _upDateTarget(value);
  }

  void _upDateTarget(PostDto postDto) {
    _likeOverride = null;
    _optimisticLike = null;
    _target = postDto;
    notifyListeners();
  }

  int get id => _target!.id;
  String get title => _target!.title;
  String get imageUrl => _target!.imageUrl;
  bool get isLiked => _optimisticLike ?? _likeOverride ?? _target!.isLiked;

  /// last successful like state change without update from the server
  bool? _likeOverride;

  /// optimistic UI update
  bool? _optimisticLike;

  void updateFromApi() {
    di<ApiClient>().getPost(_target!.id).then((postDto) {
      _upDateTarget(postDto);
    });
  }

  /// optimistic UI update
  Future<void> like(BuildContext context) async {
    _optimisticLike = true;
    notifyListeners();
    try {
      await di<ApiClient>().likePost(_target!.id);
      _likeOverride = true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to like post'),
          ),
        );
      }
      _optimisticLike = null;
      notifyListeners();
    }
  }

  Future<void> unlike(BuildContext context) async {
    _optimisticLike = false;
    notifyListeners();
    try {
      await di<ApiClient>().unlikePost(_target!.id);
      _likeOverride = false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to unlike post'),
          ),
        );
      }
      _optimisticLike = null;
      notifyListeners();
    }
  }
}

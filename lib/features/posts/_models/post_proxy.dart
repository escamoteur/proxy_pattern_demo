import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class PostProxy extends ChangeNotifier {
  late PostDto _target;
  int referenceCount = 0;

  PostProxy(this._target);

  //setter for the target
  set target(PostDto value) {
    _upDateTarget(value);
  }

  void _upDateTarget(PostDto postDto) {
    _likeOverride = null;
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

  void updateFromApi() {
    di<ApiClient>().getPost(_target.id).then((postDto) {
      _upDateTarget(postDto);
    });
  }

  /// optimistic UI update
  Future<void> like(BuildContext context) async {
    _likeOverride = true;
    notifyListeners();
    try {
      await di<ApiClient>().likePost(_target.id);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to like post'),
          ),
        );
      }
      _likeOverride = !_likeOverride!;
      notifyListeners();
    }
  }

  Future<void> unlike(BuildContext context) async {
    _likeOverride = false;
    notifyListeners();
    try {
      await di<ApiClient>().unlikePost(_target.id);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to unlike post'),
          ),
        );
      }
      _likeOverride = !_likeOverride!;
      notifyListeners();
    }
  }
}

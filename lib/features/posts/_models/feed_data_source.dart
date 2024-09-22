import 'package:flutter/foundation.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class FeedDataSource {
  final _posts = <PostProxy>[];
  final ValueNotifier<int> _postsCount = ValueNotifier(0);
  ValueListenable<int> get postsCount => _postsCount;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueListenable<bool> get isLoading => _isLoading;

  PostProxy getPostAtIndex(int index) {
    assert(index >= 0 && index < _posts.length);
    return _posts[index];
  }

  void updateData() {
    for (var post in _posts) {
      post.dispose();
    }
    _posts.clear();
    _isLoading.value = true;
    di<ApiClient>().getPosts().then((postDtos) {
      for (var postDto in postDtos) {
        _posts.add(PostProxy(postDto));
      }
      _isLoading.value = false;
      _postsCount.value = _posts.length;
    });
  }
}

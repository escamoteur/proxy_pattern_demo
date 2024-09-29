import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';
import 'package:watch_it/watch_it.dart';

class FeedDataSource {
  FeedDataSource({this.filter});

  /// select which posts to show in this feed
  final bool Function(PostDto postDto)? filter;

  final _posts = <PostProxy>[];
  final ValueNotifier<int> _postsCount = ValueNotifier(0);
  ValueListenable<int> get postsCount => _postsCount;

  PostProxy getPostAtIndex(int index) {
    assert(index >= 0 && index < _posts.length);
    return _posts[index];
  }

  late final updateDataCommand = Command.createAsyncNoParamNoResult(() async {
    final postDtos = await di<ApiClient>().getPosts();

    /// decrement the reference count of all proxies
    /// and release the ones that are not anywhere else
    di<PostManager>().releaseProxies(_posts);
    _posts.clear();

    for (var postDto in postDtos) {
      if (filter != null && !filter!(postDto)) {
        continue;
      }
      _posts.add(di<PostManager>().createProxy(postDto));
    }
    _postsCount.value = _posts.length;
  });
}

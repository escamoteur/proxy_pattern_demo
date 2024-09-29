import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';

class PostManagerImplementation extends PostManager {
  final FeedDataSource _postsFeed = FeedDataSource();
  @override
  FeedDataSource get postsFeed => _postsFeed;
  final FeedDataSource _dogPostsFeed = FeedDataSource(
    filter: (postDto) => postDto.imageUrl.contains('dog'),
  );
  @override
  FeedDataSource get dogPostsFeed => _dogPostsFeed;

  /// cache for already proxied posts
  final Map<int, PostProxy> _proxyRepository = {};

  @override
  List<PostProxy> createProxies(List<PostDto> postDtos) {
    return postDtos.map((postDto) => createProxy(postDto)).toList();
  }

  @override
  PostProxy createProxy(PostDto postDto) {
    if (_proxyRepository.containsKey(postDto.id)) {
      final existingProxy = _proxyRepository[postDto.id]!;
      existingProxy.target = postDto;
      existingProxy.referenceCount++;
      return existingProxy;
    }
    final newProxy = PostProxy(postDto);
    newProxy.referenceCount++;
    _proxyRepository[postDto.id] = newProxy;
    return newProxy;
  }

  @override
  void releaseProxies(List<PostProxy> proxies) {
    for (var proxy in proxies) {
      releaseProxy(proxy);
    }
  }

  @override
  void releaseProxy(PostProxy proxy) {
    proxy.referenceCount--;
    if (proxy.referenceCount == 0) {
      _proxyRepository.remove(proxy.id);
      proxy.dispose();
    }
  }
}

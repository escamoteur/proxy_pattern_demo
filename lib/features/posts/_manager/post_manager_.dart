import 'package:flutter/foundation.dart';
import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';

abstract class PostManager {
  /// create a proxy from a PostDto
  /// if the PostDto is already proxied, it will return the existing proxy
  PostProxy createProxy(PostDto postDto);

  /// create a list of proxies from a list of PostDto
  /// if the PostDto is already proxied, it will return the existing proxy
  List<PostProxy> createProxies(List<PostDto> postDtos);
  void releaseProxies(List<PostProxy> proxies);
  void releaseProxy(PostProxy proxy);

  /// To show the flexibilty of declarative logic with commands we will
  /// block that you can all any command to update the data from the api
  /// while any update is in progress
  ValueListenable<bool> get updateFromApiIsExecuting;

  /// this class would normally contain the business logic for the posts feature
  /// like creating, or deleting posts, for the first part of the tutorial
  /// whis will only contain the factory for the FeedDataSources
  ///
  ///
  /// all posts
  FeedDataSource get postsFeed;

  /// post with dog images
  FeedDataSource get dogPostsFeed;
}

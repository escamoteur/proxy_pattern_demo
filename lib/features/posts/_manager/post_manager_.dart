import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';

abstract class PostManager {
  /// this class would normally contain the business logic for the posts feature
  /// like creating, or deleting posts, for the first part of the tutorial
  /// whis will only contain the factory for the FeedDataSources
  ///
  ///
  FeedDataSource get postsFeed;
}

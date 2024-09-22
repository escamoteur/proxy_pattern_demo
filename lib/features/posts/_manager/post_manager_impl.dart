import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';

class PostManagerImplementation extends PostManager {
  PostManagerImplementation() {
    _postsFeed.updateData();
  }
  final FeedDataSource _postsFeed = FeedDataSource();
  @override
  FeedDataSource get postsFeed => _postsFeed;
}

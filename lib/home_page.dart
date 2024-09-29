import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/widgets/post_feed_view.dart';
import 'package:watch_it/watch_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: PostFeedView(dataSource: di<PostManager>().postsFeed)),
        Expanded(
            child: PostFeedView(dataSource: di<PostManager>().dogPostsFeed)),
      ],
    );
  }
}

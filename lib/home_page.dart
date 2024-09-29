import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/widgets/post_feed_view.dart';
import 'package:proxy_pattern_demo/the_app/the_app_.dart';
import 'package:watch_it/watch_it.dart';

class HomePage extends WatchingWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// handler to display error messages
    registerStreamHandler(
        select: (TheApp app) => app.errorMessagesStream,
        handler: (context, snapShot, _) {
          if (snapShot.hasData) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(snapShot.data!),
            ));
          }
        });
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

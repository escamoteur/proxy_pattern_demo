import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/features/posts/_manager/post_manager_.dart';
import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';
import 'package:proxy_pattern_demo/features/posts/widgets/post_card.dart';
import 'package:watch_it/watch_it.dart';

class PostFeedView extends WatchingWidget {
  const PostFeedView({required this.dataSource, super.key});

  final FeedDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    /// update the data source when the widget is first built
    callOnce((_) => dataSource.updateDataCommand());

    final int postsCount = watch(dataSource.postsCount).value;
    final bool isLoading =
        watch(dataSource.updateDataCommand.isExecuting).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _FeedUpdateWidgetButton(dataSource: dataSource),
        if (isLoading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final post = dataSource.getPostAtIndex(index);
                return PostCard(post: post);
              },
              itemCount: postsCount,
            ),
          ),
      ],
    );
  }
}

class _FeedUpdateWidgetButton extends WatchingWidget {
  const _FeedUpdateWidgetButton({
    required this.dataSource,
  });

  final FeedDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    final bool anyUpdateInProgress =
        watchValue((PostManager pm) => pm.updateFromApiIsExecuting);
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed:
          !anyUpdateInProgress ? dataSource.updateDataCommand.execute : null,
    );
  }
}

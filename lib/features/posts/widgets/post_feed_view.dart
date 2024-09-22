import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/features/posts/_models/feed_data_source.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:watch_it/watch_it.dart';

class PostFeedView extends WatchingWidget {
  const PostFeedView({required this.dataSource, super.key});

  final FeedDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    final int postsCount = watch(dataSource.postsCount).value;
    final bool isLoading = watch(dataSource.isLoading).value;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final post = dataSource.getPostAtIndex(index);
        return PostCard(post: post);
      },
      itemCount: postsCount,
    );
  }
}

class PostCard extends WatchingWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final PostProxy post;

  @override
  Widget build(BuildContext context) {
    /// watch the post to rebuild the widget when the post changes
    watch(post);
    return Card.outlined(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(aspectRatio: 16 / 9, child: Image.network(post.imageUrl)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (post.isLiked)
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () => post.unlike(context),
                )
              else
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () => post.like(context),
                ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: post.updateFromApi,
                  icon: const Icon(Icons.refresh)),
            ],
          ),
        ],
      ),
    );
  }
}

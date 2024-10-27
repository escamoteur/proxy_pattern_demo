import 'package:flutter/material.dart';
import 'package:proxy_pattern_demo/features/posts/_models/post_proxy.dart';
import 'package:proxy_pattern_demo/shared/widgets/command_icon_button.dart';
import 'package:watch_it/watch_it.dart';

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
    final bool isLoading = watch(post.updateFromApiCommand.isExecuting).value;
    return Card.outlined(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: !isLoading
                ? Image.network(post.imageUrl)
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (post.isLiked)
                CommandIconButton(
                  icon: Icons.favorite,
                  command: post.toggleLikeCommand,
                )
              else
                CommandIconButton(
                  icon: Icons.favorite_border,
                  command: post.toggleLikeCommand,
                ),
              const SizedBox(width: 8),
              CommandIconButton(
                command: post.updateFromApiCommand,
                icon: Icons.refresh,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

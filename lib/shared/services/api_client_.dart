import 'dart:math';

/// PostDto with title, image url and like state
class PostDto {
  final int id;
  final String title;
  final String imageUrl;
  final bool isLiked;

  PostDto({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isLiked,
  });

  factory PostDto.fromJson(int id, Map<String, dynamic> json) {
    return PostDto(
      id: id,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      isLiked: Random().nextBool(),
      // isLiked: json['isLiked'],
    );
  }
}

abstract class ApiClient {
  Future<List<PostDto>> getPosts();

  Future<PostDto> getPost(int id);

  Future<void> likePost(int id);
  Future<void> unlikePost(int id);
}

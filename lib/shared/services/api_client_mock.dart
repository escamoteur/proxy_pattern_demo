import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:proxy_pattern_demo/shared/services/api_client_.dart';

class ApiClientMock implements ApiClient {
  ApiClientMock();
  late final String _jsonString;

  Future<ApiClient> init() async {
    _jsonString = await rootBundle.loadString('assets/mock_data.json');

    return this;
  }

  late List<PostDto> _mockData;

  @override
  Future<List<PostDto>> getPosts() async {
    final List<dynamic> parsed = json.decode(_jsonString) as List<dynamic>;
    await Future<void>.delayed(const Duration(seconds: 2));
    _mockData = parsed
        .asMap()
        .map((index, value) => MapEntry(
            index, PostDto.fromJson(index, value as Map<String, dynamic>)))
        .values
        .toList();
    return _mockData;
  }

  /// Mock implementation of likePost with a delay of 1 second
  /// and a random chance of failing
  @override
  Future<void> likePost(int id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        if (Random().nextBool()) {
          throw Exception('Failed to like post');
        }
      },
    );
  }

  @override
  Future<void> unlikePost(int id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        if (Random().nextBool()) {
          throw Exception('Failed to unlike post');
        }
      },
    );
  }

  /// Mock implementation of getPost with a delay of 1 second
  /// with random like state
  @override
  Future<PostDto> getPost(int id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        final post = _mockData[id];
        return PostDto(
          id: post.id,
          title: post.title,
          imageUrl: post.imageUrl,
          isLiked: Random().nextBool(),
        );
      },
    );
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:proxy_pattern_demo/shared/services/api_client_.dart';

class ApiClientMock implements ApiClient {
  ApiClientMock();

  Future<ApiClient> init() async {
    final List<dynamic> parsed = json.decode(_mockDataJson) as List<dynamic>;
    await Future<void>.delayed(const Duration(seconds: 2));
    _mockData = parsed
        .asMap()
        .map((index, value) => MapEntry(
            index, PostDto.fromJson(index, value as Map<String, dynamic>)))
        .values
        .toList();
    return this;
  }

  late final List<PostDto> _mockData;

  @override
  Future<List<PostDto>> getPosts() {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return _mockData;
      },
    );
  }

  static const _mockDataJson = '''
[
  {
    "title": "Paul Jarvis",
    "imageUrl": "https://picsum.photos/id/18/400/300",
    "isLiked": true
  },
  {
    "title": "The Duck Whisperer",
    "imageUrl": "https://placedog.net/400/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/20/400/300",
    "isLiked": true
  },
  {
    "title": "When Your Wi-Fi Drops",
    "imageUrl": "https://placebear.com/400/300",
    "isLiked": false
  },
  {
    "title": "The Art of the Nap",
    "imageUrl": "https://placedog.net/401/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/22/400/300",
    "isLiked": false
  },
  {
    "title": "The Secret Life of Spoons",
    "imageUrl": "https://placebear.com/401/300",
    "isLiked": true
  },
  {
    "title": "How to Escape a Zoom Call",
    "imageUrl": "https://placedog.net/402/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/24/400/300",
    "isLiked": true
  },
  {
    "title": "A Guide to Awkward Silences",
    "imageUrl": "https://placebear.com/402/300",
    "isLiked": false
  },
  {
    "title": "When Coffee is Life",
    "imageUrl": "https://placedog.net/403/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/26/400/300",
    "isLiked": false
  },
  {
    "title": "The Adventures of Couch Potato",
    "imageUrl": "https://placebear.com/403/300",
    "isLiked": true
  },
  {
    "title": "Bananas: The Silent Superheroes",
    "imageUrl": "https://placedog.net/404/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/28/400/300",
    "isLiked": true
  },
  {
    "title": "In Search of the Perfect Nap Spot",
    "imageUrl": "https://placebear.com/404/300",
    "isLiked": false
  },
  {
    "title": "When You Accidentally Hit Reply All",
    "imageUrl": "https://placedog.net/405/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/30/400/300",
    "isLiked": false
  },
  {
    "title": "Why Dogs Chase Their Tails",
    "imageUrl": "https://placebear.com/405/300",
    "isLiked": true
  },
  {
    "title": "How to Eat a Burrito Without Spilling",
    "imageUrl": "https://placedog.net/406/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/32/400/300",
    "isLiked": true
  },
  {
    "title": "Why Friday is the Best Day",
    "imageUrl": "https://placebear.com/406/300",
    "isLiked": false
  },
  {
    "title": "The Struggles of Left-Handed People",
    "imageUrl": "https://placedog.net/407/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/34/400/300",
    "isLiked": false
  },
  {
    "title": "How to Befriend a Squirrel",
    "imageUrl": "https://placebear.com/407/300",
    "isLiked": true
  },
  {
    "title": "Adventures in Procrastination",
    "imageUrl": "https://placedog.net/408/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/36/400/300",
    "isLiked": true
  },
  {
    "title": "The Joy of Finding Spare Change",
    "imageUrl": "https://placebear.com/408/300",
    "isLiked": false
  },
  {
    "title": "The Lazy Person's Guide to Success",
    "imageUrl": "https://placedog.net/409/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/38/400/300",
    "isLiked": false
  },
  {
    "title": "The Quest for the Perfect Selfie",
    "imageUrl": "https://placebear.com/409/300",
    "isLiked": true
  },
  {
    "title": "How to Avoid Small Talk",
    "imageUrl": "https://placedog.net/410/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/40/400/300",
    "isLiked": true
  },
  {
    "title": "How to Deal with Monday Mornings",
    "imageUrl": "https://placebear.com/410/300",
    "isLiked": false
  },
  {
    "title": "The Secret Life of Couch Cushions",
    "imageUrl": "https://placedog.net/411/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/42/400/300",
    "isLiked": false
  },
  {
    "title": "How to Beat the Midweek Slump",
    "imageUrl": "https://placebear.com/411/300",
    "isLiked": true
  },
  {
    "title": "The Rise of the Lazy Sunday",
    "imageUrl": "https://placedog.net/412/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/44/400/300",
    "isLiked": true
  },
  {
    "title": "Why Unicorns Don't Exist (Yet)",
    "imageUrl": "https://placebear.com/412/300",
    "isLiked": false
  },
  {
    "title": "How to Pet a Dog Like a Pro",
    "imageUrl": "https://placedog.net/413/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/46/400/300",
    "isLiked": false
  },
  {
    "title": "Why Avocados are Always Extra",
    "imageUrl": "https://placebear.com/413/300",
    "isLiked": true
  },
  {
    "title": "How to Survive a Long Meeting",
    "imageUrl": "https://placedog.net/414/300",
    "isLiked": false
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/48/400/300",
    "isLiked": true
  },
  {
    "title": "How to Cook Instant Noodles Like a Chef",
    "imageUrl": "https://placebear.com/414/300",
    "isLiked": false
  },
  {
    "title": "The Great Debate: Socks with Sandals",
    "imageUrl": "https://placedog.net/415/300",
    "isLiked": true
  },
  {
    "title": "Alejandro Escamilla",
    "imageUrl": "https://picsum.photos/id/50/400/300",
    "isLiked": false
  },
  {
    "title": "Why Ice Cream Fixes Everything",
    "imageUrl": "https://placebear.com/415/300",
    "isLiked": true
  }
]
''';

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

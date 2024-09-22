import 'dart:convert';
import 'dart:math';

import 'package:proxy_pattern_demo/shared/services/api_client_.dart';

class ApiClientMock implements ApiClient {
  ApiClientMock();

  Future<ApiClient> init() async {
    final List<dynamic> parsed = json.decode(_mockDataJson);
    await Future.delayed(const Duration(seconds: 2));
    _mockData = parsed
        .asMap()
        .map((index, value) => MapEntry(index, PostDto.fromJson(index, value)))
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


    "title": "Why Cats Hate Mondays",
    "imageUrl": "https://loremflickr.com/400/300/cat",
    "isLiked": true
  },
  {
    "title": "The Duck Whisperer",
    "imageUrl": "https://placedog.net/400/300",
    "isLiked": false
  },
  {
    "title": "Pizza: A Love Story",
    "imageUrl": "https://loremflickr.com/400/300/pizza",
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
    "title": "Why Tacos are Better Than Therapy",
    "imageUrl": "https://loremflickr.com/400/300/tacos",
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
    "title": "Adventures in Netflix Bingeing",
    "imageUrl": "https://loremflickr.com/400/300/netflix",
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
    "title": "How to Survive Without Wi-Fi",
    "imageUrl": "https://loremflickr.com/400/300/technology",
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
    "title": "Confessions of a Chocolate Addict",
    "imageUrl": "https://loremflickr.com/400/300/chocolate",
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
    "title": "The Mystery of Missing Socks",
    "imageUrl": "https://loremflickr.com/400/300/socks",
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
    "title": "The Art of Doing Nothing",
    "imageUrl": "https://loremflickr.com/400/300/relax",
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
    "title": "Pizza vs. Tacos: The Ultimate Showdown",
    "imageUrl": "https://loremflickr.com/400/300/pizza,tacos",
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
    "title": "When Your Alarm Betrays You",
    "imageUrl": "https://loremflickr.com/400/300/clock",
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
    "title": "Why Pancakes Are Superior",
    "imageUrl": "https://loremflickr.com/400/300/pancakes",
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
    "title": "Cats: Masters of the Universe",
    "imageUrl": "https://loremflickr.com/400/300/cats",
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
    "title": "Why Donuts Make You Happy",
    "imageUrl": "https://loremflickr.com/400/300/donuts",
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
    "title": "When You Can't Find the Remote",
    "imageUrl": "https://loremflickr.com/400/300/remote",
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
    "title": "The Joy of Sleeping In",
    "imageUrl": "https://loremflickr.com/400/300/sleeping",
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
    "title": "The Epic Tale of Missing Car Keys",
    "imageUrl": "https://loremflickr.com/400/300/carkeys",
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
    "title": "How to Win at Hide and Seek",
    "imageUrl": "https://loremflickr.com/400/300/hideandseek",
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

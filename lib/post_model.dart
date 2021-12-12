import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.parseJson(json)).toList();
}

Future<List<Post>> fetchPosts(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  return compute(parsePosts, response.body);
}

class Post {
  final int albumId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.albumId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.parseJson(Map<String, dynamic> data) {
    return Post(
      albumId: data['albumId'] as int,
      id: data['id'] as int,
      title: data['title'] as String,
      body: data['body'] as String,
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.parseJson(Map<String, dynamic> data) {
    return Photo(
      albumId: data['albumId'] as int,
      id: data['id'] as int,
      title: data['title'] as String,
      url: data['url'] as String,
      thumbnailUrl: data['thumbnailUrl'] as String,
    );
  }

  static List<Photo> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Photo>((json) => Photo.parseJson(json)).toList();
  }

  static Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    return compute(parsePhotos, response.body);
  }
}

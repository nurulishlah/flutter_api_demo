import 'package:api_demo/photo_model.dart';
import 'package:api_demo/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        // body: FutureBuilder<List<Post>>(
        //   future: fetchPosts(http.Client()),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(child: Text('${snapshot.hasError}'));
        //     } else if (snapshot.hasData) {
        //       return PostsList(
        //         posts: snapshot.data!,
        //       );
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
        body: FutureBuilder<List<Photo>>(
          future: Photo.fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.hasError}'));
            } else if (snapshot.hasData) {
              return PhotosList(
                photos: snapshot.data!,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}

class PostsList extends StatelessWidget {
  const PostsList({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.article),
              ),
              title: Text(
                posts[index].title,
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                posts[index].body,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

// Define a class to represent the data for each post
class PostData {
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final int likesCount;
  final String description;
  final int commentsCount;

  PostData({
    required this.username,
    required this.avatarUrl,
    required this.imageUrl,
    required this.likesCount,
    required this.description,
    required this.commentsCount,
  });
}

// Widget to display a single post
class PostWidget extends StatelessWidget {
  final PostData postData;

  const PostWidget({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the header of the post
        _PostHeader(username: postData.username, avatarUrl: postData.avatarUrl),

        // Display the main content of the post (image)
        _Post(imageUrl: postData.imageUrl),

        // Display interaction buttons (like, comment, share)
        _PostInteractionButtons(likesCount: postData.likesCount),

        // Display post interactions (username, description, comments count)
        _PostsInteractions(
          username: postData.username,
          description: postData.description,
          commentsCount: postData.commentsCount,
        ),
      ],
    );
  }
}

// Header of the post containing the user's avatar and username
class _PostHeader extends StatelessWidget {
  const _PostHeader({Key? key, required this.username, required this.avatarUrl})
      : super(key: key);

  final String username;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // User's avatar
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrRMHThLy0_Kq7eU7AwuhDoOiI5yyIyQQARA&usqp=CAU',
              ),
              radius: 21,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ali',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}

// Main content of the post (image)
class _Post extends StatelessWidget {
  const _Post({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Interaction buttons (like, comment, share)
class _PostInteractionButtons extends StatelessWidget {
  const _PostInteractionButtons({Key? key, required this.likesCount})
      : super(key: key);

  final int likesCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Like button
          Row(
            children: [
              Icon(Icons.favorite),
              SizedBox(
                width: 5,
              ),
              Text('like'),
            ],
          ),

          // Comment button
          Row(
            children: [
              Icon(Icons.comment),
              SizedBox(
                width: 5,
              ),
              Text('Comment'),
            ],
          ),

          // Share button
          Row(
            children: [
              Icon(Icons.share),
              SizedBox(
                width: 5,
              ),
              Text('Share'),
              Divider(
                height: 1,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Post interactions (username, description, comments count)
class _PostsInteractions extends StatelessWidget {
  const _PostsInteractions(
      {Key? key,
      required this.username,
      required this.description,
      required this.commentsCount})
      : super(key: key);

  final String username;
  final String description;
  final int commentsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Column(
          children: [
            // Display user avatar and likes count
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNNl92qNwzhP_M2qyyq78DG2GPMokRD1WfmA&usqp=CAU'),
                  radius: 13,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('static'),
                SizedBox(
                  width: 5,
                ),
                Text('Likes'),
              ],
            ),

            // Display username and description
            Row(
              children: [
                Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(description),
              ],
            ),

            // Display comments count
            Row(
              children: [
                Text('View all $commentsCount comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Main HomePage class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// State class for HomePage
class _HomePageState extends State<HomePage> {
  // Dummy list of posts
  List<PostData> posts = [
    PostData(
      username: 'ali',
      avatarUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrRMHThLy0_Kq7eU7AwuhDoOiI5yyIyQQARA&usqp=CAU',
      imageUrl:
          'https://avatars.mds.yandex.net/i?id=8437e262024b4e10bd9f92d52253abf7-5357304-images-taas-consumers&n=27&h=480&w=480',
      likesCount: 1234,
      description: 'Here is my description, and I will implement API later',
      commentsCount: 18,
    ),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TREND',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      // Use ListView.builder to display a list of posts
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          // Use PostWidget to display each post
          return PostWidget(postData: posts[index]);
        },
      ),
    );
  }
}

// Entry point of the Flutter app
void main() {
  runApp(MyApp());
}

// MyApp class to configure and run the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

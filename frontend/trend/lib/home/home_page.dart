import 'package:flutter/material.dart';
import 'package:trend/posts/data/models.dart';
import 'package:trend/posts/data/remote_data.dart';
import 'package:trend/widgets/comment_sheet.dart';
import 'package:trend/widgets/info_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// no code framework
class _HomePageState extends State<HomePage> {
  List<PostModel> posts = [];

  ///2
  @override
  void initState() {
    super.initState();
    displayPosts();
  }

//1
  void displayPosts() async {
    final List<PostModel> posts = await fetchPosts();
    setState(() {
      this.posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text(
          'TREND',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
        )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return _MainPostContainer(
              post: posts[index],
            );
          },
        ),
      ),
    );
  }
}

class _PostHeader extends StatefulWidget {
  const _PostHeader({super.key, required this.post});
  final PostModel post;

  @override
  State<_PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<_PostHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.post.image,
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
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const InfoSheet();
                    });
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}

class _Post extends StatefulWidget {
  const _Post({super.key, required this.post});
  final PostModel post;
  @override
  State<_Post> createState() => __PostState();
}

class __PostState extends State<_Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.network(
        widget.post.image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PostInteractionButtons extends StatefulWidget {
  const _PostInteractionButtons({super.key});

  @override
  State<_PostInteractionButtons> createState() =>
      __PostInteractionButtonsState();
}

class __PostInteractionButtonsState extends State<_PostInteractionButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(Icons.favorite),
              SizedBox(
                width: 5,
              ),
              Text('like'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.comment),
              SizedBox(
                width: 5,
              ),
              Text('Comment'),
            ],
          ),
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

class _PostsInteractions extends StatefulWidget {
  const _PostsInteractions({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  State<_PostsInteractions> createState() => __PostsInteractionsState();
}

class __PostsInteractionsState extends State<_PostsInteractions> {
  final String _userName = 'ali';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNNl92qNwzhP_M2qyyq78DG2GPMokRD1WfmA&usqp=CAU'),
                radius: 13,
              ),
              SizedBox(
                width: 5,
              ),
              Text('422'),
              SizedBox(
                width: 5,
              ),
              Text('Likes'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // color: Colors.red.shade400,
                  ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: RichText(
                    maxLines: 3,
                    text: TextSpan(
                      text: '$_userName  ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.post.description.isNotEmpty
                              ? widget.post.description
                              : 'No comment here',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return CommentSheet(
                          post: widget.post,
                          description: widget.post.description,
                          image: widget.post.image,
                        );
                      },
                    );
                  },
                  child: const Text('View all 18 comments'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MainPostContainer extends StatefulWidget {
  const _MainPostContainer({super.key, required this.post});
  final PostModel post;
  @override
  State<_MainPostContainer> createState() => __MainPostContainerState();
}

class __MainPostContainerState extends State<_MainPostContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        _PostHeader(post: widget.post),
        _Post(
          post: widget.post,
        ),
        const _PostInteractionButtons(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _PostsInteractions(
            post: widget.post,
          ),
        ),
      ],
    ));
  }
}

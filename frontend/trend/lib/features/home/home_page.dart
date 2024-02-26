import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/posts/data/models.dart';
import 'package:trend/features/posts/data/remote_data.dart';
import 'package:trend/features/widgets/comment_sheet.dart';
import 'package:trend/features/widgets/info_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// no code framework
class _HomePageState extends State<HomePage> {
  List<PostModel> posts = [];
  bool isLoading = false;

  ///2
  @override
  void initState() {
    super.initState();
    displayPosts();
  }

//1
  void displayPosts() async {
    setState(() {
      isLoading = true;
    });
    final List<PostModel> posts = await fetchPosts();
    setState(() {
      this.posts = posts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 8,
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _MainPostContainer(
                  post: posts[index],
                );
              },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post.author.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
    return SizedBox(
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
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/heart.svg",
                color: Colors.black,
                height: 21,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Like'),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/comment.svg",
                color: Colors.black,
                height: 22.5,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Comment'),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/share.svg",
                color: Colors.black,
                height: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Share'),
              const Divider(
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
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNNl92qNwzhP_M2qyyq78DG2GPMokRD1WfmA&usqp=CAU'),
                radius: 11,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '422',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'likes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Container(
                  child: RichText(
                    maxLines: 3,
                    text: TextSpan(
                      text: '$_userName  ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.post.description.isNotEmpty
                              ? widget.post.description
                              : 'No comment here',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
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
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
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
                  child: const Text(
                    'View all 18 comments',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
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
    return Column(
      children: [
        _PostHeader(post: widget.post),
        _Post(
          post: widget.post,
        ),
        const _PostInteractionButtons(),
        const Divider(height: .05, thickness: .3),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _PostsInteractions(
            post: widget.post,
          ),
        ),
      ],
    );
  }
}

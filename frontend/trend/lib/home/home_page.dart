import 'package:flutter/material.dart';
import 'package:trend/home/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SingleChildScrollView(
        child: const Column(
          children: [
            _MainPostContainer(),
            SizedBox(
              height: 20,
            ),
            _MainPostContainer(),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
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

class _Post extends StatefulWidget {
  const _Post({super.key});

  @override
  State<_Post> createState() => __PostState();
}

class __PostState extends State<_Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.network(
        "https://avatars.mds.yandex.net/i?id=8437e262024b4e10bd9f92d52253abf7-5357304-images-taas-consumers&n=27&h=480&w=480",
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
  const _PostsInteractions({super.key});

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
              Text('1234'),
              SizedBox(
                width: 5,
              ),
              Text('Likes'),
            ],
          ),
          Container(
            child: Row(
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
                        children: const [
                          TextSpan(
                            text:
                                'My other Line should be herer Line should be herer Line should be herer Line should be herer Line should be herer Line should be herer Line should be here',
                            style: TextStyle(
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
          ),
          const Row(
            children: [
              Text('View all 18 comments'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MainPostContainer extends StatefulWidget {
  const _MainPostContainer({super.key});

  @override
  State<_MainPostContainer> createState() => __MainPostContainerState();
}

class __MainPostContainerState extends State<_MainPostContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Column(
      children: [
        _PostHeader(),
        _Post(),
        _PostInteractionButtons(),
        _PostsInteractions(),
      ],
    ));
  }
}

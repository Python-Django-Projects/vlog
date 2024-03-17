import 'package:flutter/material.dart';
import 'package:trend/features/posts/data/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<PostModel> posts = [];
  final double coverHeight = 250;
  final double profileHeight = 100;

  @override
  void initState() {
    super.initState();
    displayPosts();
  }

  void displayPosts() async {
    // final List<PostModel> posts = await fetchPosts();
    // setState(() {
    //   this.posts = posts;
    // });
  }

  void displayUserName() async {
    // final List<PostModel> posts = await fetchPosts();
    // setState(() {
    //   this.posts = posts;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTop(),
            informationContent(),
            gridView(),
          ],
        ),
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 1.2;
    final top = coverHeight - profileHeight / 1.5;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget informationContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 24),
      child: Column(
        children: [
          Text(
            posts[0].author.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(posts[0].description),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    '452',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text('posts')
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    Text(
                      '42',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text('followers')
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '572',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text('following')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 140,
                height: 35,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color(0xff0063E1)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Follow',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 140,
                height: 35,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color(0xff0063E1)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCoverImage() {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuKmzjYulECD9I4ERduqu7FQ9b9l0_N1Ib2ocC1tCsGQ&s",
      fit: BoxFit.cover,
      width: double.infinity,
      height: coverHeight,
    );
  }

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 1.5,
        backgroundColor: Colors.white,
        backgroundImage: const NetworkImage(
          "https://th.bing.com/th/id/OIG.MxQxUggA0RKmKdTjwAqw",
        ),
      );

  Widget gridView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(posts[index].image),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

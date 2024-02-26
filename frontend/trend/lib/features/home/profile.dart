import 'package:flutter/material.dart';
import 'package:trend/features/posts/data/models.dart';
import 'package:trend/features/posts/data/remote_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<PostModel> posts = [];
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  void initState() {
    super.initState();
    displayPosts();
  }

  void displayPosts() async {
    final List<PostModel> posts = await fetchPosts();
    setState(() {
      this.posts = posts;
    });
  }

  void displayUserName() async {
    final List<PostModel> posts = await fetchPosts();
    setState(() {
      this.posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          informationContent(),
          gridView(),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        // height: 200,
        child: Column(
          children: [
            Text(posts[0].author.toString()),
            const SizedBox(
              height: 10,
            ),
            Text(posts[0].description),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      '452',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text('posts')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '42',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text('followers')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '572',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text('following')
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(Colors.blue),
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
      itemCount: posts.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(5),
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

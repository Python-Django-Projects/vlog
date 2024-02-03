import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildTop(),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 1.3;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(child: buildProfileImage(), top: top),
      ],
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
        radius: profileHeight / 1.3,
        backgroundColor: Colors.white,
        backgroundImage: const NetworkImage(
          "https://th.bing.com/th/id/OIG.MxQxUggA0RKmKdTjwAqw",
        ),
      );
}

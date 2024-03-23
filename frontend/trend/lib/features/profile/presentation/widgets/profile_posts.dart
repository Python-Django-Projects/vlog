import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trend/core/widgets/post_square_media.dart';
import '../../../../core/dump_data/dump_posts.dart';

class ProfilePostsWidget extends StatelessWidget {
  const ProfilePostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.same,
        pattern: [
          const QuiltedGridTile(2, 2),
          for (var _ in posts) const QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) => InkWell(
          onTap: () {},
          child: CustomSquarePostMediaWidget(imageUrl: posts[index]),
        ),
      ),
    );
  }
}

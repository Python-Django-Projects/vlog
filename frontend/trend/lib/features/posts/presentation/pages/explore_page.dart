import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/widgets/post_square_media.dart';
import '../../../../core/dump_data/dump_posts.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.custom(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 3,
            mainAxisSpacing: 2.sp,
            crossAxisSpacing: 2.sp,
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
                child: CustomSquarePostMediaWidget(
                  imageUrl: posts[index],
                )),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp)
              .copyWith(bottom: 8.sp, top: 16.sp),
          child: CustomTextFormField(
            labelStyle: TextStyle(
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontSize: 14.sp),
            labelText: "Search...".hardcoded,
            onChange: (value) {},
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    );
  }
}

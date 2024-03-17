import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/widgets/post_square_media.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List posts = [
    'https://images.unsplash.com/photo-1682687982502-1529b3b33f85?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
    'https://plus.unsplash.com/premium_photo-1710294629911-8c89c30aa310?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8',
    'https://images.unsplash.com/photo-1682686579688-c2ba945eda0e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710372165237-2a2ada353c15?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1710385174405-df7e2060b1a2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxN3x8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710089765274-1437a79a7524?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710336723033-bfae8216b139?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyM3x8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1707327259268-2741b50ef5e5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1682686581663-179efad3cd2f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzNnx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710362921917-2e33bb342a23?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOXx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710209614924-6bf12ec19b85?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710286124248-0f0a49dd460e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710362921917-2e33bb342a23?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOXx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710209614924-6bf12ec19b85?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1710286124248-0f0a49dd460e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8fA%3D%3D',
  ];

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

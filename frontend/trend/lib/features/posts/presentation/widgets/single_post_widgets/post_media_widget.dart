import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/core/resources/color_manager.dart';
import 'single_post_images_slider_widget.dart';

class PostMediaWidget extends StatefulWidget {
  const PostMediaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PostMediaWidget> createState() => _PostMediaWidgetState();
}

class _PostMediaWidgetState extends State<PostMediaWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isAnimating = false;
  double _heartSize = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween(begin: 1.0, end: 1.5).animate(_controller)
      ..addListener(() {
        setState(() {
          _heartSize = 30.sp * _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _isAnimating = false;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateHeart() async {
    if (!_isAnimating) {
      _isAnimating = true;
      _controller.forward();
      await Future.delayed(const Duration(milliseconds: 300));
      _controller.reset();
    }
  }

  Future<void> _likeOrUnLikePost(BuildContext context) async {
    _animateHeart();
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _heartSize = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await _likeOrUnLikePost(context);
      },
      child: SizedBox(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: InteractiveViewer(
                child: SinglePostImagesSliderWidget(
                  onIndexChanged: (index) {},
                ),
              ),
            ),
            _heartSize > 0
                ? Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.favorite,
                      color: kRedColor,
                      size: _heartSize,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

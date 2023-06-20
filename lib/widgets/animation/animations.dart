import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class AnimationWidget extends StatefulWidget {
  final String assetData;
  final Duration durationData;
  final bool repeat;

  const AnimationWidget({
    Key? key,
    this.durationData = const Duration(milliseconds: 6000),
    this.assetData = 'assets/animations/emptyBox.json',
    this.repeat = true,
  }) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.assetData,
      controller: _controller,
      onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        _controller.duration = widget.durationData;
        if (widget.repeat) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
      },
    );
  }
}

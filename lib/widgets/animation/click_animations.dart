import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class ClickAnimationWidget extends StatefulWidget {
  final String assetData;
  final Duration durationData;
  final Duration reverseDurationData;

  final Function forward;
  final Function backward;

  const ClickAnimationWidget({
    Key? key,
    this.durationData = const Duration(milliseconds: 200),
    this.reverseDurationData = const Duration(milliseconds: 200),
    this.assetData = 'assets/animations/emptyBox.json',
    required this.forward,
    required this.backward,
  }) : super(key: key);

  @override
  State<ClickAnimationWidget> createState() => _ClickAnimationWidgetState();
}

class _ClickAnimationWidgetState extends State<ClickAnimationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool forward = false;

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
    return GestureDetector(
      onTap: () {
        if (forward) {
          _controller.forward();
          forward = false;
          widget.forward();
        } else {
          _controller.reverse();
          forward = true;
          widget.backward();
        }
      },
      child: Lottie.asset(
        widget.assetData,
        controller: _controller,
        onLoaded: (composition) {
          _controller.duration = widget.durationData;
          _controller.reverseDuration = widget.reverseDurationData;
          _controller.forward();
        },
      ),
    );
  }
}

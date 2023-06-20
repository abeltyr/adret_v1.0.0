import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class ProductLoading extends StatefulWidget {
  final String loading;
  final double size;
  final Color color;
  const ProductLoading({
    Key? key,
    this.loading = "assets/icons/productLoading.svg",
    this.size = 25,
    this.color = DarkModePlatformTheme.black,
  }) : super(key: key);

  @override
  State<ProductLoading> createState() => _ProductLoadingState();
}

class _ProductLoadingState extends State<ProductLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: SvgPicture.asset(
          widget.loading,
          width: widget.size,
          height: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}

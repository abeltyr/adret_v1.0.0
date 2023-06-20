import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adret/utils/theme.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  final Color color;
  final double minHeight;
  final double maxHeight;
  final Duration duration;
  const LoadingScreen({
    Key? key,
    this.color = DarkModePlatformTheme.black,
    this.minHeight = 250,
    this.maxHeight = 250,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);
  static const routeName = '/loading';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double count;

  Timer? _timer;
  @override
  void initState() {
    count = widget.minHeight;
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (Timer timer) {
        if (count < widget.maxHeight) {
          count = count + 10;
        } else {
          count = widget.minHeight;
        }
        if (mounted) {
          setState(() {});
        } else {
          timer.cancel();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer!.isActive) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: widget.color,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: widget.duration,
        width: MediaQuery.of(context).size.width,
        height: count,
        child: Lottie.asset(
          'assets/animations/productLoading.json',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

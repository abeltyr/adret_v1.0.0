import 'package:adret/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceRangeCheckBox extends StatefulWidget {
  final bool active;
  final Function onClick;
  const PriceRangeCheckBox({
    super.key,
    this.active = false,
    required this.onClick,
  });

  @override
  State<PriceRangeCheckBox> createState() => _PriceRangeCheckBoxState();
}

class _PriceRangeCheckBoxState extends State<PriceRangeCheckBox>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  bool selected = false;
  @override
  void initState() {
    super.initState();
    selected = widget.active;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animate() {
    if (selected) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    selected != selected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animate();
        selected = !selected;
        widget.onClick();
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset(
              "assets/animations/checkBox.json",
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = const Duration(milliseconds: 400);
                if (selected) {
                  _controller.forward();
                }
              },
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            AppLocalizations.of(context)!.range,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: DarkModePlatformTheme.secondBlack,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              wordSpacing: 0.1,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

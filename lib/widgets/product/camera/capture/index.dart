import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:flutter/material.dart';

class CaptureButton extends StatefulWidget {
  final Function onClick;
  final bool loading;
  const CaptureButton({
    super.key,
    required this.onClick,
    this.loading = false,
  });

  @override
  State<CaptureButton> createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  double borderScale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.loading) widget.onClick();
      },
      onTapDown: (onTapDown) {
        if (!widget.loading) {
          setState(() {
            borderScale = 2;
          });
        }
      },
      onTapUp: (onTapUp) {
        setState(() {
          borderScale = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          borderScale = 1;
        });
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: (MediaQuery.of(context).size.width / 5),
          width: (MediaQuery.of(context).size.width / 5),
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 25,
          // ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 10 * borderScale,
              color: DarkModePlatformTheme.white,
            ),
            borderRadius: BorderRadius.circular(50),
            // color: DarkModePlatformTheme.,
          ),
          child: widget.loading
              ? const AnimationWidget(
                  assetData: "assets/animations/loading.json",
                  durationData: Duration(milliseconds: 3000),
                )
              : const Stack()),
    );
  }
}

import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButton extends StatefulWidget {
  final Function onClick;
  final String? icon;
  final String? iconLoading;
  final String? title;
  final Color color;
  final Color textColor;
  final FontWeight textFontWeight;
  final double textFontSize;
  final double borderRadiusData;
  final double horizontalPadding;
  final bool loading;
  final bool disabled;

  const MainButton({
    Key? key,
    required this.onClick,
    this.title,
    this.icon,
    this.iconLoading,
    this.color = DarkModePlatformTheme.white,
    this.textColor = DarkModePlatformTheme.secondBlack,
    this.textFontWeight = FontWeight.w800,
    this.textFontSize = 20,
    this.borderRadiusData = 10.0,
    this.horizontalPadding = 0,
    this.loading = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          if (!widget.loading && !widget.disabled) await widget.onClick();
          // ignore: empty_catches
        } catch (e) {}
      },
      onTapDown: (onTapDown) {
        if (!widget.loading) {
          setState(() {
            opacity = 0.7;
          });
        }
      },
      onTapUp: (onTapUp) {
        setState(() {
          opacity = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          opacity = 1;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10000),
        child: Opacity(
          opacity: widget.disabled ? 0.65 : opacity,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  widget.loading ? widget.color.withOpacity(0.9) : widget.color,
              borderRadius: BorderRadius.circular(widget.borderRadiusData),
            ),
            padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: !widget.loading
                        ? SvgPicture.asset(
                            widget.icon!,
                            width: widget.textFontSize + 6,
                            height: widget.textFontSize + 6,
                            color: widget.textColor,
                          )
                        : SizedBox(
                            width: widget.textFontSize + 6,
                            height: widget.textFontSize + 6,
                            child: const AnimationWidget(
                              assetData: "assets/animations/refresh.json",
                              repeat: true,
                              durationData: Duration(milliseconds: 2000),
                            ),
                          ),
                  ),
                if (widget.title != null) const SizedBox(width: 5),
                if (widget.title != null)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.title!,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: widget.loading
                            ? widget.textColor.withOpacity(0.9)
                            : widget.textColor,
                        fontWeight: widget.textFontWeight,
                        fontSize: !widget.disabled && opacity == 1
                            ? widget.textFontSize
                            : widget.textFontSize + 0.5,
                        wordSpacing: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

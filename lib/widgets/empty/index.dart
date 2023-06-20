import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/animations.dart';
import 'package:adret/widgets/button/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatefulWidget {
  final String? topText;
  final double height;
  final String? subText;
  final String? actionText;
  final String? actionIcon;
  final String? animationIcon;
  final String? emptyIcon;
  final Function? action;
  const EmptyState({
    super.key,
    this.animationIcon,
    this.height = 175,
    this.emptyIcon,
    this.topText,
    this.subText,
    this.actionIcon,
    this.actionText,
    this.action,
  });

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 8 / 12,
            height: widget.height,
            child: widget.emptyIcon != null
                ? SvgPicture.asset(
                    widget.emptyIcon!,
                    color: DarkModePlatformTheme.white,
                  )
                : AnimationWidget(
                    durationData: const Duration(seconds: 3),
                    assetData: widget.animationIcon ??
                        'assets/animations/emptyBox.json',
                  ),
          ),
          if (widget.emptyIcon != null)
            const SizedBox(
              height: 20,
            ),
          if (widget.topText != null)
            Text(
              widget.topText!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Nunito',
                color: DarkModePlatformTheme.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                wordSpacing: 0.1,
              ),
            ),
          const SizedBox(
            height: 7.5,
          ),
          if (widget.subText != null)
            Text(
              widget.subText!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Nunito',
                color: DarkModePlatformTheme.white,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                wordSpacing: 0.1,
              ),
            ),
          const SizedBox(
            height: 25,
          ),
          if (widget.action != null &&
              widget.actionText != null &&
              widget.actionIcon != null)
            SizedBox(
              height: 40,
              child: MainButton(
                icon: widget.actionIcon,
                loading: loading,
                title: widget.actionText!,
                borderRadiusData: 10,
                onClick: () async {
                  if (widget.action != null) {
                    setState(() {
                      loading = true;
                    });
                    await widget.action!();
                    setState(() {
                      loading = false;
                    });
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

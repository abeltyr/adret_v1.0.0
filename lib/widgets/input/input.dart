import 'package:adret/model/input/index.dart';
import 'package:adret/utils/theme.dart';
import 'package:adret/widgets/animation/click_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final Function valueSetter;
  final String? icon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function? validation;
  final Function(String)? onChanged;
  final Function(String)? onDone;
  final bool divider;
  final bool requiredField;
  final TextCapitalization textCapitalization;
  final double ratio1;
  final double ratio2;
  final double size;
  final double borderPadding;
  final double paddingData;
  final Color color;
  final bool showError;
  final FocusNode? focus;
  const Input(
      {Key? key,
      this.controller,
      required this.label,
      required this.valueSetter,
      this.icon,
      this.ratio1 = 1.2,
      this.ratio2 = 10.8,
      this.size = 25,
      this.borderPadding = 10,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.validation,
      this.onChanged,
      this.onDone,
      this.requiredField = true,
      this.showError = true,
      this.divider = false,
      this.textCapitalization = TextCapitalization.none,
      this.color = DarkModePlatformTheme.darkWhite,
      this.focus,
      this.paddingData = 10.0})
      : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;
  late InputModel value;
  bool isPassword = false;
  double passwordIconSize = 32.5;
  TextInputType textInputType = TextInputType.text;

  @override
  void initState() {
    super.initState();
    value = widget.valueSetter();
    _controller = TextEditingController(text: "");
    textInputType = widget.textInputType;
    if (value.input != null && widget.controller == null) {
      _controller.text = value.input.toString();
    }
    if (widget.textInputType == TextInputType.visiblePassword) {
      isPassword = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.icon != null)
                    Container(
                      constraints: const BoxConstraints(maxWidth: 55),
                      width: constrains.maxWidth * widget.ratio1 / 12,
                      child: SvgPicture.asset(
                        widget.icon!,
                        width: constrains.maxWidth * widget.ratio1 / 12,
                        height: constrains.maxWidth * widget.ratio1 / 12,
                        color: widget.color,
                      ),
                    ),
                  SizedBox(
                    height: widget.size + 9,
                    child: SizedBox(
                      width: constrains.maxWidth * widget.ratio2 / 12,
                      child: TextFormField(
                        onChanged: widget.onChanged,
                        controller: widget.controller ?? _controller,
                        keyboardType: textInputType,
                        textInputAction: widget.textInputAction,
                        textCapitalization: widget.textCapitalization,
                        maxLines: 1,
                        enableSuggestions: false,
                        obscureText:
                            textInputType == TextInputType.visiblePassword,
                        onFieldSubmitted: widget.onDone,
                        autocorrect: false,
                        focusNode: widget.focus,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: DarkModePlatformTheme.white,
                          fontWeight: FontWeight.w600,
                          fontSize: widget.size,
                          wordSpacing: 0.1,
                        ),
                        cursorColor: DarkModePlatformTheme.white,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Nunito",
                            fontSize: widget.size - 2,
                            wordSpacing: 1,
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusColor: DarkModePlatformTheme.white,
                          hintText: widget.label,
                          contentPadding: EdgeInsets.fromLTRB(
                              widget.paddingData,
                              0,
                              (isPassword
                                  ? passwordIconSize + 5
                                  : widget.borderPadding),
                              0),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.divider)
                Padding(
                  padding: EdgeInsets.only(right: widget.borderPadding),
                  child: const Divider(color: DarkModePlatformTheme.darkWhite),
                ),
              Visibility(
                visible: value.errorStatus && widget.showError,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 5.0, top: widget.divider ? 0 : 5),
                  child: Text(
                    "${value.errorMessage}",
                    style: const TextStyle(
                      color: DarkModePlatformTheme.negativeLight2,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Nunito",
                      fontSize: 10,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isPassword)
            Positioned(
              right: 0,
              bottom: 20,
              top: 2,
              child: SizedBox(
                width: passwordIconSize,
                child: ClickAnimationWidget(
                  assetData: 'assets/animations/eye.json',
                  durationData: const Duration(milliseconds: 200),
                  reverseDurationData: const Duration(milliseconds: 200),
                  forward: () {
                    setState(() {
                      textInputType = TextInputType.visiblePassword;
                    });
                  },
                  backward: () {
                    setState(() {
                      textInputType = TextInputType.text;
                    });
                  },
                ),
              ),
            )
        ],
      );
    });
  }
}

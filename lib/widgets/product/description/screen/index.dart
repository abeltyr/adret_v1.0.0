import 'package:adret/model/input/index.dart';
import 'package:adret/widgets/header/textHeader/index.dart';
import 'package:flutter/material.dart';
import 'package:adret/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionScreen extends StatefulWidget {
  final InputModel initialData;
  final bool disable;
  final Function(String) saveData;
  final bool focus;
  final String label;

  const DescriptionScreen({
    Key? key,
    required this.initialData,
    required this.saveData,
    this.disable = false,
    required this.focus,
    required this.label,
  }) : super(key: key);
  static const routeName = '/description';

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late TextEditingController _controller;

  late FocusNode textFocusNode;
  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    _controller = TextEditingController(
      text: widget.initialData.input != null
          ? widget.initialData.input.toString()
          : "",
    );
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);

    if (widget.focus) {
      textFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: DarkModePlatformTheme.secondBlack,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            if (widget.disable)
              TextHeader(
                closeText: AppLocalizations.of(context)!.close,
                showCloseText: true,
                showActionText: false,
                centerText: AppLocalizations.of(context)!.description,
                actionFunction: () {
                  Navigator.pop(context);
                },
              )
            else
              TextHeader(
                actionText: AppLocalizations.of(context)!.add,
                closeText: AppLocalizations.of(context)!.back,
                centerText: AppLocalizations.of(context)!.description,
                actionFunction: () {
                  widget.saveData(_controller.text);
                  Navigator.pop(context);
                },
              ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      focusNode: textFocusNode,
                      readOnly: widget.disable,
                      maxLines: null,
                      enableSuggestions: true,
                      autocorrect: true,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: DarkModePlatformTheme.white,
                        fontWeight: FontWeight.w200,
                        fontSize: 18,
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
                        hintStyle: const TextStyle(
                          color: DarkModePlatformTheme.grey5,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Nunito",
                          fontSize: 18,
                          wordSpacing: 1,
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusColor: DarkModePlatformTheme.white,
                        hintText: widget.label,
                        contentPadding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/string.dart';
import 'package:gocast/widgets/strut_text.dart';

/// General purpose text input field using [CupertinoTextField].
class ThemeTextInput extends StatefulWidget {
  const ThemeTextInput({
    Key key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTapIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.helpText,
    this.maxLines = 1,
    this.readOnly = false,
    this.clearButtonMode = OverlayVisibilityMode.editing,
    this.validator,
    this.lengthLimit = 0,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTapIcon;
  final GestureTapCallback onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Icon icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String helpText;
  final int maxLines;
  final bool readOnly;
  final OverlayVisibilityMode clearButtonMode;
  final FormFieldValidator<String> validator;
  final int lengthLimit;

  @override
  ThemeTextInputState createState() => ThemeTextInputState();
}

class ThemeTextInputState extends State<ThemeTextInput> {
  String _errorText = '';

  /// The current validation error returned by the [ThemeTextInput.validator]
  /// callback, or null if no errors have been triggered. This only updates when
  /// [validate] is called.
  String get errorText => _errorText;

  /// True if this field has any validation errors.
  bool get hasError => _errorText != null;

  /// Calls [ThemeTextInput.validator] to set the [widget.errorText].
  /// Returns true if there were no errors.
  bool validate() {
    setState(() {
      if (widget.validator != null) {
        _errorText = widget.validator(widget.controller.text);
      }
    });
    return !hasError;
  }

  Widget _showErrorLabel() {
    if (_errorText.isNullOrEmpty) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(top: kPaddingS / 2),
      child: StrutText(
        _errorText,
        style: Theme.of(context)
            .textTheme
            .caption
            .fs14
            .copyWith(color: Theme.of(context).errorColor),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _showHelpText() {
    if (widget.helpText == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(top: kPaddingS / 2),
      child: StrutText(
        widget.helpText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.caption.fs14,
      ),
    );
  }

  Widget _showTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(kBoxDecorationRadius),
      ),
      child: Stack(
        children: <Widget>[
          CupertinoTextField(
            autocorrect: false,
            onTap: widget.onTap,
            textAlignVertical: TextAlignVertical.center,
            onSubmitted: widget.onSubmitted,
            controller: widget.controller,
            focusNode: widget.focusNode,
            onChanged: (String value) {
              validate();
              if (widget.onChanged != null) {
                widget.onChanged(value);
              }
            },
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            cursorColor: Theme.of(context).hintColor,
            style: Theme.of(context).textTheme.bodyText2.fs16,
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(kFormFieldsRadius),
              border: Border.all(
                width: 2,
                color: _errorText.isNotNullOrEmpty
                    ? Theme.of(context).errorColor
                    : Theme.of(context).inputDecorationTheme.fillColor,
              ),
            ),
            clearButtonMode: widget.clearButtonMode,
            readOnly: widget.readOnly,
            suffix: widget.icon != null
                ? IconButton(
                    icon: widget.icon,
                    onPressed: widget.onTapIcon,
                  )
                : null,
            placeholder: widget.hintText,
            placeholderStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).hintColor,
            ),
            inputFormatters: <TextInputFormatter>[
              if (widget.lengthLimit > 0)
                LengthLimitingTextInputFormatter(widget.lengthLimit),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.bottomStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _showTextField(),
          _showErrorLabel(),
          _showHelpText(),
        ],
      ),
    );
  }
}

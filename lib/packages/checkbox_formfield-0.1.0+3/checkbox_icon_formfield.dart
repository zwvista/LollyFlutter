import 'package:flutter/material.dart';

/// Use Icon as checkbox
class CheckboxIconFormField extends FormField<bool> {
  CheckboxIconFormField({
    Key? key,
    BuildContext? context,
    FormFieldSetter<bool>? onSaved,
    bool initialValue = false,
    bool autovalidate = false,
    bool enabled = true,
    IconData trueIcon = Icons.check,
    IconData falseIcon = Icons.check_box_outline_blank,
    Color? trueIconColor,
    Color? falseIconColor,
    Color? disabledColor,
    double padding = 24.0,
    double? iconSize,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<bool> state) {
            trueIconColor ??= (context == null
                ? null
                : Theme.of(context).accentIconTheme.color);

            return Padding(
                padding: EdgeInsets.all(padding),
                child: state.value!
                    ? _createTappableIcon(state, enabled, trueIcon,
                        trueIconColor!, disabledColor!, iconSize!)
                    : _createTappableIcon(state, enabled, falseIcon,
                        falseIconColor!, disabledColor!, iconSize!));
          },
        );

  static Widget _createTappableIcon(FormFieldState<bool> state, bool enabled,
      IconData icon, Color iconColor, Color disabledColor, double iconSize) {
    return IconButton(
      onPressed: enabled
          ? () {
              state.didChange(!state.value!);
            }
          : null,
      icon: Icon(icon,
          color: enabled ? iconColor : disabledColor, size: iconSize),
    );
  }
}

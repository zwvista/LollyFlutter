import 'package:flutter/material.dart';

/// Use CheckboxListTile as part of Form
class CheckboxListTileFormField extends FormField<bool> {
  CheckboxListTileFormField({
    Key? key,
    Widget? title,
    BuildContext? context,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
    bool enabled = true,
    bool dense = false,
    Color? errorColor,
    Color? activeColor,
    Color? checkColor,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
    Widget? secondary,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<bool> state) {
            errorColor ??= (context == null
                ? Colors.red
                : Theme.of(context).colorScheme.error);

            return CheckboxListTile(
              title: title,
              dense: dense,
              activeColor: activeColor,
              checkColor: checkColor,
              value: state.value,
              onChanged: enabled ? state.didChange : null,
              subtitle: state.hasError
                  ? Text(
                      state.errorText ?? "",
                      style: TextStyle(color: errorColor),
                    )
                  : null,
              controlAffinity: controlAffinity,
              secondary: secondary,
            );
          },
        );
}

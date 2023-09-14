import 'package:flutter/material.dart';
import 'package:my_notes/note/exception/validate_exception.dart';

class TextInput extends StatelessWidget {
  final String? initialValue;
  final void Function(String value)? validator;
  final String? hint;
  final bool enabled;
  final void Function(String value)? onChanged;
  final int? rows;

  const TextInput({
    super.key,
    this.enabled = true,
    this.initialValue,
    this.validator,
    this.hint,
    this.onChanged,
    this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      maxLines: rows ?? 1,
      validator: (value) {
        try {
          validator?.call(value ?? '');
          return null;
        } on ValidateException catch (e) {
          return e.message;
        }
      },
    );
  }
}
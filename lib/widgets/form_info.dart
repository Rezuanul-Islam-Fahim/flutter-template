import 'package:flutter/material.dart';

class FormInfo extends StatelessWidget {
  const FormInfo({
    super.key,
    required this.title,
    required this.inputHintText,
    this.enabled = true,
    this.hintColor,
    this.onChanged,
  });

  final String title;
  final String inputHintText;
  final bool enabled;
  final Color? hintColor;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        const SizedBox(height: 5),
        TextField(
          onChanged: onChanged,
          enabled: enabled,
          scrollPadding: const EdgeInsets.all(85.0),
          decoration: InputDecoration(
            hintText: inputHintText,
            hintStyle: theme.textTheme.titleLarge!.copyWith(
              color: hintColor ?? Colors.grey[400],
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[200]!,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[200]!,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[200]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ReusableFormField extends StatefulWidget {
  final IconData iconData;
  final String hintText;
  final Icon? suffixIcon;
  final bool isPasswordField;
  // final void Function(String? value) onChanged;
  final TextEditingController controller;

  const ReusableFormField({
    super.key,
    required this.hintText,
    required this.iconData,
    this.suffixIcon,
    this.isPasswordField = false,
    // required this.onChanged,
    required this.controller,
  });

  @override
  State<ReusableFormField> createState() => _ReusableFormFieldState();
}

class _ReusableFormFieldState extends State<ReusableFormField> {
  bool obsecureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // initialValue: widget.initialValue,
      obscureText: widget.isPasswordField && !obsecureText,
      // onChanged: widget.onChanged,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColor.withValues(alpha: 0.05),
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.iconData,
          size: 20,
        ),
        suffixIcon: widget.isPasswordField
            ? obsecureText
                ? IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () => setState(() => obsecureText = false),
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  )
                : IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () => setState(() => obsecureText = true),
                    icon: const Icon(Icons.visibility_off_outlined),
                  )
            : null,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.color
              ?.withValues(alpha: 0.6),
          letterSpacing: 0.8,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }
}

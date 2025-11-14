import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.isPassword,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      cursorHeight: 20,

      style: const TextStyle(color: Colors.black),

      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Please fill ${widget.hintText}";
        }

        // Email Regex
        if (widget.keyboardType == TextInputType.emailAddress) {
          final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$');
          if (!emailRegex.hasMatch(v.trim())) {
            return "Please enter a valid email";
          }
        }

        // Password Regex
        if (widget.isPassword) {
          final passwordRegex = RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@#$!%*?&]).{8,}$',
          );
          if (!passwordRegex.hasMatch(v.trim())) {
            return "Password must be 8+ chars, include A-Z, a-z, number, symbol";
          }
        }

        return null;
      },

      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child:
                      _obscureText
                          ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                          : const Icon(Icons.visibility, color: Colors.black),
                )
                : null,
        hintText: widget.hintText,

        hintStyle: const TextStyle(color: Colors.black54),

        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

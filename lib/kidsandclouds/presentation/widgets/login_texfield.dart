import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_textfield.dart'; 



class LoginTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final bool isError; 
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? errorText;
  
  const LoginTextField({
    super.key,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.isError = false,
    this.controller,
    this.suffixIcon,
    this.errorText,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {

  @override
  Widget build(BuildContext context) {
    Widget? finalSuffixIcon = widget.suffixIcon;
    
   

    return CustomTextField(
      label: widget.label,
      obscureText: widget.obscureText,
      controller: widget.controller,
      isError: widget.isError,
      errorText: widget.errorText,
      suffixIcon: finalSuffixIcon,
    );
  }
}
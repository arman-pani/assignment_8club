import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:flutter/material.dart';

class MultilineTextfield extends StatefulWidget {
  final String hintText;
  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const MultilineTextfield({
    super.key,
    required this.maxLines,
    required this.maxLength,
    required this.hintText,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<MultilineTextfield> createState() => _MultilineTextfieldState();
}

class _MultilineTextfieldState extends State<MultilineTextfield>
    with WidgetsBindingObserver {
  bool keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;

    setState(() {
      keyboardOpen = bottomInset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double defaultHeight = widget.maxLines * 28;
    double keyboardHeight = 4 * 28;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: keyboardOpen
          ? keyboardHeight
          : defaultHeight,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        expands: true,
        maxLength: widget.maxLength,
        controller: widget.controller,
        onChanged: (value) => widget.onChanged(value),
        style: AppTextStyles.b1.copyWith(color: AppColors.text1),
        cursorColor: AppColors.text1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.primaryAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: AppColors.surfaceWhite2,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          hintText: widget.hintText,
          hintStyle: AppTextStyles.h3.copyWith(color: AppColors.text5),
        ),
      ),
    );
  }
}

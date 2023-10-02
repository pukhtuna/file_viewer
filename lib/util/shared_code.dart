import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  const CustomText({
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.overflow,
    this.textDecoration,
    this.maxLines,
    this.height,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: fontSize ?? 14,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
          fontWeight: fontWeight,
          color: color ?? Theme.of(context).colorScheme.onBackground,
          height: height),
    );
  }
}

showLoading() {
  return const Center(
    child: CircularProgressIndicator.adaptive(),
  );
}

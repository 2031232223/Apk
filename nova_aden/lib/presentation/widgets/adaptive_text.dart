import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 24.0; // Tamaño base
    
    // Lógica de ajuste: si el texto es muy largo, reduce el tamaño progresivamente
    if (text.length > 10) fontSize = 18.0;
    if (text.length > 14) fontSize = 16.0;
    if (text.length > 18) fontSize = 14.0;
    if (text.length > 22) fontSize = 12.0;
    if (text.length > 30) fontSize = 10.0;

    return Text(
      text,
      style: style?.copyWith(fontSize: fontSize),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis, // Corta con "..." si es imposible mostrarlo todo
    );
  }
}

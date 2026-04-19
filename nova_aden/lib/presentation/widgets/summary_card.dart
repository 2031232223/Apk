import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // Determinamos el tamaño de fuente basado en la longitud del valor
    double fontSize = 24.0;
    if (value.length > 10) fontSize = 16.0;
    if (value.length > 15) fontSize = 14.0;
    if (value.length > 20) fontSize = 12.0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  // Usamos Text.rich o ajustamos el estilo dinámicamente
                  Text(
                    value, 
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      height: 1.1, // Reduce espacio vertical si es necesario
                    ),
                    overflow: TextOverflow.ellipsis, // Corta el texto si es imposible mostrarlo
                    maxLines: 2, // Limita a 2 líneas
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[500])),
                  ],
                ],
              ),
            ),
            Icon(icon, size: 40, color: iconColor ?? Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}

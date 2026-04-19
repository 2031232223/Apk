import 'package:flutter/material.dart';
import 'adaptive_text.dart'; // Importamos el widget inteligente

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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AdaptiveText(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  // AQUÍ ESTÁ LA MAGIA: AdaptiveText ajusta el tamaño automáticamente
                  AdaptiveText(
                    value, 
                    style: TextStyle(
                      fontSize: 24.0, // Base
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      height: 1.1,
                    ),
                    maxLines: 2,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    AdaptiveText(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[500])),
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

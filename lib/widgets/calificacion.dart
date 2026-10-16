import 'package:flutter/material.dart';

class Calificacion extends StatelessWidget {
  final double valor;

  const Calificacion({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, color: Color(0xFFE3AD42), size: 20),
        const SizedBox(width: 4),
        Text(
          valor.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

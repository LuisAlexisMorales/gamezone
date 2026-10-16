import 'package:flutter/material.dart';

class EtiquetaGenero extends StatelessWidget {
  final String genero;

  const EtiquetaGenero({super.key, required this.genero});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEFEA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genero,
        style: const TextStyle(
          color: Color(0xFF176B60),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

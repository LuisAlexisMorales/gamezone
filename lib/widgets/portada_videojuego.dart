import 'package:flutter/material.dart';

class PortadaVideojuego extends StatelessWidget {
  final String imagen;
  final double altura;

  const PortadaVideojuego({super.key, required this.imagen, this.altura = 160});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: altura,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imagen,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF263449),
              alignment: Alignment.center,
              child: const Icon(
                Icons.videogame_asset,
                size: 48,
                color: Colors.white70,
              ),
            );
          },
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }

            return Container(
              color: const Color(0xFF263449),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

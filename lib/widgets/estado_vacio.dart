import 'package:flutter/material.dart';

class EstadoVacio extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String descripcion;

  const EstadoVacio({
    super.key,
    required this.icono,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(descripcion, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EncabezadoSeccion extends StatelessWidget {
  final String titulo;
  final String? accion;
  final VoidCallback? alPresionar;

  const EncabezadoSeccion({
    super.key,
    required this.titulo,
    this.accion,
    this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        if (accion != null)
          TextButton(onPressed: alPresionar, child: Text(accion!)),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AvatarPerfil extends StatelessWidget {
  final String nombre;
  const AvatarPerfil({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    final texto = nombre.trim();
    return Semantics(
      label: 'Avatar de $texto',
      child: CircleAvatar(
        radius: 40,
        child: Text(
          texto.isEmpty ? '?' : texto.characters.first.toUpperCase(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

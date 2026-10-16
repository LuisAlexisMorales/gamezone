import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import '../services/favoritos_service.dart';

class BotonFavorito extends StatelessWidget {
  final Videojuego videojuego;
  final FavoritosService? servicio;

  const BotonFavorito({super.key, required this.videojuego, this.servicio});

  @override
  Widget build(BuildContext context) {
    final favoritos = servicio ?? FavoritosService.instancia;
    return ListenableBuilder(
      listenable: favoritos,
      builder: (context, child) {
        final seleccionado = favoritos.esFavorito(videojuego.id);
        return IconButton(
          tooltip: seleccionado ? 'Quitar de favoritos' : 'Agregar a favoritos',
          isSelected: seleccionado,
          icon: const Icon(Icons.favorite_border),
          selectedIcon: const Icon(Icons.favorite),
          onPressed: () => favoritos.alternar(videojuego),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../services/favoritos_service.dart';
import '../widgets/estado_vacio.dart';
import '../widgets/tarjeta_favorito.dart';

class FavoritosScreen extends StatelessWidget {
  final FavoritosService? servicio;

  const FavoritosScreen({super.key, this.servicio});

  @override
  Widget build(BuildContext context) {
    final favoritos = servicio ?? FavoritosService.instancia;
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListenableBuilder(
        listenable: favoritos,
        builder: (context, child) {
          final juegos = favoritos.favoritos;
          if (juegos.isEmpty) {
            return const EstadoVacio(
              icono: Icons.favorite_border,
              titulo: 'Todavía no tienes favoritos',
              descripcion:
                  'Abre un videojuego y toca el corazón para guardarlo aquí.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: juegos.length,
            itemBuilder: (context, index) => TarjetaFavorito(
              key: ValueKey(juegos[index].id),
              videojuego: juegos[index],
              servicio: favoritos,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import '../services/favoritos_service.dart';
import '../screens/detalle_screen.dart';
import 'boton_favorito.dart';
import 'tarjeta_videojuego.dart';

class TarjetaFavorito extends StatelessWidget {
  final Videojuego videojuego;
  final FavoritosService? servicio;

  const TarjetaFavorito({super.key, required this.videojuego, this.servicio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TarjetaVideojuego(
          videojuego: videojuego,
          alPresionar: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => DetalleScreen(
                videojuego: videojuego,
                favoritosService: servicio,
              ),
            ),
          ),
        ),
        BotonFavorito(videojuego: videojuego, servicio: servicio),
        const SizedBox(height: 8),
      ],
    );
  }
}

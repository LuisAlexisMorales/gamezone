import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import 'portada_videojuego.dart';
import 'etiqueta_genero.dart';
import 'calificacion.dart';

class TarjetaVideojuego extends StatelessWidget {
  final Videojuego videojuego;
  final VoidCallback alPresionar;

  const TarjetaVideojuego({
    super.key,
    required this.videojuego,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: alPresionar,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PortadaVideojuego(imagen: videojuego.imagen, altura: 160),
              const SizedBox(height: 12),
              Text(
                videojuego.nombre,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: EtiquetaGenero(genero: videojuego.genero)),
                  const SizedBox(width: 8),
                  Calificacion(valor: videojuego.calificacion),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

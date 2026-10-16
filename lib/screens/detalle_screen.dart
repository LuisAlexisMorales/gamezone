import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import '../services/favoritos_service.dart';
import '../widgets/boton_favorito.dart';
import '../widgets/portada_videojuego.dart';
import '../widgets/etiqueta_genero.dart';
import '../widgets/calificacion.dart';

class DetalleScreen extends StatelessWidget {
  final Videojuego videojuego;
  final FavoritosService? favoritosService;

  const DetalleScreen({
    super.key,
    required this.videojuego,
    this.favoritosService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del videojuego'),
        actions: [
          BotonFavorito(videojuego: videojuego, servicio: favoritosService),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PortadaVideojuego(imagen: videojuego.imagen, altura: 220),
            ),

            const SizedBox(height: 20),

            Text(
              videojuego.nombre,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            EtiquetaGenero(genero: videojuego.genero),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Calificación',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Calificacion(valor: videojuego.calificacion),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.devices_rounded, size: 30),
                title: const Text('Plataformas'),
                subtitle: Text(videojuego.plataforma),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Descripción',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              videojuego.descripcion,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al catálogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

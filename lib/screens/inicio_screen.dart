import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import '../services/videojuego_service.dart';
import '../widgets/tarjeta_videojuego.dart';
import '../widgets/encabezado_seccion.dart';
import 'catalogo_screen.dart';
import 'detalle_screen.dart';

class InicioScreen extends StatelessWidget {
  InicioScreen({super.key});

  final VideojuegoService servicio = VideojuegoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameZone'),
        actions: [
          IconButton(
            tooltip: 'Abrir catálogo',
            icon: const Icon(Icons.grid_view_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CatalogoScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Videojuego>>(
        future: servicio.cargarVideojuegos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No fue posible cargar el catálogo.\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final juegos = snapshot.data ?? [];

          if (juegos.isEmpty) {
            return const Center(child: Text('No hay videojuegos disponibles.'));
          }

          final destacados = juegos.take(3).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Descubre tu próximo juego',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explora aventuras, mundos y nuevas experiencias.',
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              const SizedBox(height: 24),
              EncabezadoSeccion(
                titulo: 'Juegos destacados',
                accion: 'Ver catálogo',
                alPresionar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CatalogoScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              for (final Videojuego juego in destacados)
                TarjetaVideojuego(
                  videojuego: juego,
                  alPresionar: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleScreen(videojuego: juego),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CatalogoScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.explore),
                label: const Text('Explorar todos los juegos'),
              ),
            ],
          );
        },
      ),
    );
  }
}

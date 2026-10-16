import 'package:flutter/material.dart';

import '../models/videojuego.dart';
import '../services/videojuego_service.dart';
import '../widgets/tarjeta_videojuego.dart';
import '../widgets/etiqueta_genero.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final VideojuegoService servicio = VideojuegoService();
  final TextEditingController buscador = TextEditingController();
  late Future<List<Videojuego>> futuroVideojuegos;

  String textoBusqueda = '';
  String generoSeleccionado = 'Todos';

  @override
  void initState() {
    super.initState();
    futuroVideojuegos = servicio.cargarVideojuegos();
  }

  @override
  void dispose() {
    buscador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: FutureBuilder<List<Videojuego>>(
        future: futuroVideojuegos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los videojuegos:\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final juegos = snapshot.data ?? [];

          final generos = <String>[
            'Todos',
            ...juegos.map((juego) => juego.genero).toSet(),
          ];

          final filtrados = juegos.where((juego) {
            final coincideNombre = juego.nombre.toLowerCase().contains(
              textoBusqueda.toLowerCase(),
            );

            final coincideGenero =
                generoSeleccionado == 'Todos' ||
                juego.genero == generoSeleccionado;

            return coincideNombre && coincideGenero;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: buscador,
                  onChanged: (valor) {
                    setState(() {
                      textoBusqueda = valor;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar videojuego...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: generos.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final genero = generos[index];
                    final seleccionado = genero == generoSeleccionado;

                    return ChoiceChip(
                      label: genero == 'Todos'
                          ? const Text('Todos')
                          : EtiquetaGenero(genero: genero),
                      selected: seleccionado,
                      onSelected: (valor) {
                        setState(() {
                          generoSeleccionado = genero;
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${filtrados.length} videojuegos encontrados',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: filtrados.isEmpty
                    ? const Center(
                        child: Text('No se encontraron videojuegos.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          final juego = filtrados[index];

                          return TarjetaVideojuego(
                            videojuego: juego,
                            alPresionar: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(juego.nombre),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      '${juego.descripcion}\n\n'
                                      'Género: ${juego.genero}\n'
                                      'Plataforma: ${juego.plataforma}\n'
                                      'Calificación: '
                                      '${juego.calificacion}',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

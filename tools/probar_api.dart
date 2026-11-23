// Herramienta de demostración: consume la API real de GameZone desde Dart.
// Requisito: tener el servidor corriendo (cd api-mock && npm run start).
//
// Ejecutar desde la raíz del repo:
//   dart run tools/probar_api.dart
//   dart run tools/probar_api.dart http://localhost:3000
//
// Es una herramienta de consola: print es la salida esperada.
// ignore_for_file: avoid_print
import 'package:gamezone/services/videojuegos_api.dart';

Future<void> main(List<String> argumentos) async {
  final base = argumentos.isNotEmpty
      ? argumentos.first
      : VideojuegosApi.baseUrlPorDefecto;
  final api = VideojuegosApi(baseUrl: base);
  print('API base: $base\n');

  final juegos = await api.fetchVideojuegos();
  print('GET /videojuegos -> ${juegos.length} videojuegos');
  for (final juego in juegos) {
    print('  [${juego.id}] ${juego.nombre} — ${juego.genero} '
        '(⭐ ${juego.calificacion})');
  }

  final detalle = await api.fetchVideojuegoPorId(juegos.first.id);
  print('\nGET /videojuegos/${detalle.id} -> ${detalle.nombre}');
  print('  ${detalle.descripcion}');
}

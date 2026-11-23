import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gamezone/models/videojuego.dart';
import 'package:gamezone/services/videojuego_service.dart';
import 'package:gamezone/services/videojuegos_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Videojuego juego(int id) => Videojuego(
  id: id,
  nombre: 'Juego $id',
  genero: 'Aventura',
  plataforma: 'PC',
  calificacion: 9,
  descripcion: 'Una aventura.',
  imagen: 'https://example.com/juego$id.jpg',
);

Map<String, dynamic> jsonJuego(int id) => {
  'id': id,
  'nombre': 'Juego $id',
  'genero': 'Aventura',
  'plataforma': 'PC',
  'calificacion': 9.0,
  'descripcion': 'Una aventura.',
  'imagen': 'https://example.com/juego$id.jpg',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('VideojuegosApi parsea la lista de GET /videojuegos', () async {
    final api = VideojuegosApi(
      cliente: MockClient((peticion) async {
        expect(peticion.url.path, '/videojuegos');
        return http.Response(
          jsonEncode([jsonJuego(1), jsonJuego(2)]),
          200,
        );
      }),
    );

    final juegos = await api.fetchVideojuegos();
    expect(juegos.length, 2);
    expect(juegos.first.nombre, 'Juego 1');
    expect(juegos.last.calificacion, 9.0);
  });

  test('VideojuegosApi parsea GET /videojuegos/:id', () async {
    final api = VideojuegosApi(
      cliente: MockClient((peticion) async {
        expect(peticion.url.path, '/videojuegos/3');
        return http.Response(jsonEncode(jsonJuego(3)), 200);
      }),
    );

    final juego = await api.fetchVideojuegoPorId(3);
    expect(juego.id, 3);
    expect(juego.nombre, 'Juego 3');
  });

  test('VideojuegosApi lanza excepción con un estado HTTP de error', () async {
    final api = VideojuegosApi(
      cliente: MockClient((peticion) async => http.Response('error', 500)),
    );

    expect(api.fetchVideojuegos(), throwsException);
    expect(api.fetchVideojuegoPorId(1), throwsException);
  });

  test('VideojuegoService usa la API cuando responde correctamente', () async {
    final servicio = VideojuegoService(
      api: VideojuegosApi(
        cliente: MockClient(
          (peticion) async => http.Response(jsonEncode([jsonJuego(7)]), 200),
        ),
      ),
    );

    final juegos = await servicio.cargarVideojuegos();
    expect(juegos.single.id, 7);
    expect(servicio.ultimaFuente, 'api');
  });

  test('VideojuegoService respalda con el JSON local si la API falla', () async {
    final servicio = VideojuegoService(
      api: VideojuegosApi(
        cliente: MockClient((peticion) async => http.Response('error', 500)),
      ),
    );

    final juegos = await servicio.cargarVideojuegos();
    expect(juegos.length, 6);
    expect(juegos.first.nombre, 'Minecraft');
    expect(servicio.ultimaFuente, 'local');
  });

  test('cargarVideojuegoPorId conserva el respaldo si la API falla', () async {
    final servicio = VideojuegoService(
      api: VideojuegosApi(
        cliente: MockClient((peticion) async => http.Response('error', 404)),
      ),
    );

    final respaldo = juego(99);
    final resultado = await servicio.cargarVideojuegoPorId(99, respaldo: respaldo);
    expect(resultado.id, 99);
    expect(servicio.ultimaFuente, 'local');
  });
}

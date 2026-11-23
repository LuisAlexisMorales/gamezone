import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/videojuego.dart';
import 'videojuegos_api.dart';

class VideojuegoService {
  VideojuegoService({VideojuegosApi? api}) : _api = api ?? VideojuegosApi();

  final VideojuegosApi _api;

  /// Fuente de la última carga exitosa: 'api' o 'local'.
  String ultimaFuente = 'local';

  /// Carga el catálogo consumiendo `GET /videojuegos`.
  /// Si la API no está disponible, usa el JSON local como respaldo
  /// para que la aplicación siga funcionando sin servidor.
  Future<List<Videojuego>> cargarVideojuegos() async {
    try {
      final juegos = await _api.fetchVideojuegos();
      ultimaFuente = 'api';
      return juegos;
    } catch (_) {
      ultimaFuente = 'local';
      return _cargarLocal();
    }
  }

  /// Consume `GET /videojuegos/:id`. Si falla, devuelve el respaldo
  /// (por ejemplo, el objeto recibido desde la lista).
  Future<Videojuego> cargarVideojuegoPorId(
    int id, {
    required Videojuego respaldo,
  }) async {
    try {
      final juego = await _api.fetchVideojuegoPorId(id);
      ultimaFuente = 'api';
      return juego;
    } catch (_) {
      ultimaFuente = 'local';
      return respaldo;
    }
  }

  Future<List<Videojuego>> _cargarLocal() async {
    final String contenido = await rootBundle.loadString(
      'assets/data/videojuegos.json',
    );

    final List<dynamic> datos = jsonDecode(contenido);

    return datos.map((dato) {
      return Videojuego.fromJson(dato as Map<String, dynamic>);
    }).toList();
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/videojuego.dart';

/// Cliente HTTP del catálogo de GameZone.
///
/// Consume la API mock (`api-mock/`, json-server) o cualquier servidor que
/// exponga los mismos endpoints:
///   GET /videojuegos      -> lista completa
///   GET /videojuegos/:id  -> un videojuego por id
///
/// La URL base se puede cambiar al compilar:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
class VideojuegosApi {
  VideojuegosApi({http.Client? cliente, String? baseUrl})
    : _cliente = cliente ?? http.Client(),
      _baseUrl = baseUrl ?? baseUrlPorDefecto;

  static const String baseUrlPorDefecto = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const Duration _tiempoLimite = Duration(seconds: 5);

  final http.Client _cliente;
  final String _baseUrl;

  Future<List<Videojuego>> fetchVideojuegos() async {
    final respuesta = await _cliente
        .get(Uri.parse('$_baseUrl/videojuegos'))
        .timeout(_tiempoLimite);

    if (respuesta.statusCode != 200) {
      throw Exception('Error HTTP ${respuesta.statusCode} al cargar el catálogo');
    }

    final List<dynamic> datos = jsonDecode(respuesta.body) as List<dynamic>;
    return datos
        .map((dato) => Videojuego.fromJson(dato as Map<String, dynamic>))
        .toList();
  }

  Future<Videojuego> fetchVideojuegoPorId(int id) async {
    final respuesta = await _cliente
        .get(Uri.parse('$_baseUrl/videojuegos/$id'))
        .timeout(_tiempoLimite);

    if (respuesta.statusCode != 200) {
      throw Exception('Error HTTP ${respuesta.statusCode} al cargar el videojuego $id');
    }

    return Videojuego.fromJson(
      jsonDecode(respuesta.body) as Map<String, dynamic>,
    );
  }
}

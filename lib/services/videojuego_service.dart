import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/videojuego.dart';

class VideojuegoService {
  Future<List<Videojuego>> cargarVideojuegos() async {
    final String contenido = await rootBundle.loadString(
      'assets/data/videojuegos.json',
    );

    final List<dynamic> datos = jsonDecode(contenido);

    return datos.map((dato) {
      return Videojuego.fromJson(dato as Map<String, dynamic>);
    }).toList();
  }
}

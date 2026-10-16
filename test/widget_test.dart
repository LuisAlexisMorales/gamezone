import 'package:flutter_test/flutter_test.dart';

import 'package:gamezone/models/videojuego.dart';

void main() {
  test('Videojuego.fromJson parses a game', () {
    final videojuego = Videojuego.fromJson({
      'id': 1,
      'nombre': 'Minecraft',
      'genero': 'Sandbox',
      'plataforma': 'PC',
      'calificacion': 9,
      'descripcion': 'Explora y construye.',
      'imagen': 'https://example.com/minecraft.jpg',
    });

    expect(videojuego.id, 1);
    expect(videojuego.nombre, 'Minecraft');
    expect(videojuego.genero, 'Sandbox');
    expect(videojuego.plataforma, 'PC');
    expect(videojuego.calificacion, 9.0);
    expect(videojuego.descripcion, 'Explora y construye.');
    expect(videojuego.imagen, 'https://example.com/minecraft.jpg');
  });
}

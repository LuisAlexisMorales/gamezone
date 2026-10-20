import 'package:flutter/foundation.dart';

import '../models/videojuego.dart';

/// Colección en memoria compartida por las pantallas durante esta sesión.
class FavoritosService extends ChangeNotifier {
  static final FavoritosService instancia = FavoritosService();

  final Map<int, Videojuego> _favoritos = {};

  List<Videojuego> get favoritos => List.unmodifiable(_favoritos.values);

  bool esFavorito(int id) => _favoritos.containsKey(id);

  void agregar(Videojuego videojuego) {
    if (esFavorito(videojuego.id)) return;
    _favoritos[videojuego.id] = videojuego;
    notifyListeners();
  }

  void eliminar(int id) {
    if (_favoritos.remove(id) != null) notifyListeners();
  }

  void alternar(Videojuego videojuego) {
    if (esFavorito(videojuego.id)) {
      eliminar(videojuego.id);
    } else {
      agregar(videojuego);
    }
  }
}

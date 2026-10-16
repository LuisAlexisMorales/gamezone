# Implementar módulo de Favoritos con estado compartido y pruebas

Permite guardar juegos desde Detalle, abrir la colección desde Inicio y
eliminar favoritos desde sus tarjetas o desde el detalle. La lista se actualiza
automáticamente y muestra un estado vacío al quitar el último juego.

- FavoritosService con ChangeNotifier, deduplicación por ID y lista inmutable.
- BotonFavorito, TarjetaFavorito y EstadoVacio reutilizables.
- Reutilización del modelo, tarjetas, tema y respaldo de imágenes existentes.
- Integración mínima en Inicio y Detalle, sin cambios en main.dart.
- Compatibilidad con Dart 3.12 y actualización del lock para el SDK instalado.
- flutter pub get completado, flutter analyze sin incidencias y 7 pruebas aprobadas.

Base: main. El PR #1 ya estaba fusionado al comenzar. Los favoritos se guardan
en memoria durante la sesión. Perfil y la navegación general quedan fuera de
esta contribución. No fusionar automáticamente.

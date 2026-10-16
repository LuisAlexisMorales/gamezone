# Contribución del integrante 2: Favoritos

Repositorio: LuisAlexisMorales/gamezone. Integrante: al3-dan.
Rama: feature/favoritos, basada en main después de la fusión del PR #1.

## Funcionamiento

Desde Inicio, el corazón de la barra superior abre Favoritos. Desde el detalle
de cualquier juego se puede agregar o quitar el favorito. Las tarjetas de
Favoritos abren el mismo detalle y permiten quitar el juego con su corazón.
Cuando se elimina el último, aparece un mensaje para comenzar una colección.

FavoritosService extiende ChangeNotifier y guarda los videojuegos en un mapa
por ID, evitando duplicados. La lista pública es una copia inmutable. Solo
notifica cuando realmente cambia la colección. ListenableBuilder reconstruye
los botones y la lista automáticamente. Las pantallas usan instancia para
compartir el servicio, y admiten inyectar otro servicio para pruebas aisladas.
Los datos se conservan durante la sesión y se pierden al reiniciar la app.

TarjetaFavorito reutiliza TarjetaVideojuego, que muestra portada, nombre,
género y calificación. PortadaVideojuego ya ofrece respaldo ante fallos de red.
EstadoVacio admite icono, título y descripción, con desplazamiento para
pantallas pequeñas y texto ampliado. No se implementaron Perfil ni una barra
de navegación general. main.dart y el modelo original permanecen intactos.

## Archivos

Nuevos:
- lib/services/favoritos_service.dart
- lib/screens/favoritos_screen.dart
- lib/widgets/boton_favorito.dart
- lib/widgets/tarjeta_favorito.dart
- lib/widgets/estado_vacio.dart
- test/favoritos_test.dart
- FAVORITOS.md y PR_FAVORITOS.md

Modificados:
- lib/screens/inicio_screen.dart: acceso a Favoritos.
- lib/screens/detalle_screen.dart: corazón e inyección opcional del servicio.
- pubspec.yaml y pubspec.lock: compatibilidad con Flutter 3.44.9 / Dart 3.12.2.
  La restricción mínima se ajustó de Dart 3.13 a 3.12; el código no utiliza
  características exclusivas de 3.13. El lock refleja las dependencias del SDK.

## Ejecutar y verificar

```powershell
cd C:\Users\camar\Downloads\gamezone-favoritos
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Resultados: pub get completado; analyze sin incidencias; 7 pruebas aprobadas
(6 nuevas y la prueba existente del modelo). Las pruebas nuevas cubren IDs
duplicados, notificaciones, lista inmutable, alternancia, sincronización entre
botones, navegación, eliminación desde detalle y lista, respaldo de imágenes,
estado vacío con texto ampliado y acceso desde Inicio.

## Defensa técnica

Implementé el módulo de Favoritos reutilizando el modelo y las tarjetas del
equipo. Separé el estado en un servicio observable y la presentación en tres
widgets reutilizables. Las pantallas comparten la misma instancia, por eso un
cambio en Detalle se refleja en Favoritos. Evité duplicados por ID y protegí
la colección de modificaciones externas. Validé el flujo con pruebas unitarias
y de widgets sin modificar la contribución del integrante 1.

## Publicar

Una vez autenticado en GitHub con acceso de escritura:

```powershell
git push -u origin feature/favoritos
```

Crear el PR con base main y comparación feature/favoritos. Usar el título y
descripción de PR_FAVORITOS.md. No fusionarlo automáticamente.

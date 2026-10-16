# Entrega del integrante 2: GameZone

## Funcionalidades

Favoritos permite agregar y quitar juegos por ID con estado compartido.
Perfil muestra un nombre editable, un avatar con su inicial, la cantidad de
juegos favoritos y la cantidad de géneros únicos. El nombre y los favoritos
son datos locales de sesión; no existe autenticación ni persistencia en disco.

La navegación inferior conecta Inicio, Catálogo, Favoritos y Perfil mediante
IndexedStack. Mantiene el nombre y la búsqueda al cambiar de sección. Detalle
es la quinta pantalla y se abre desde las tarjetas de Inicio, Catálogo o
Favoritos, con regreso mediante Navigator. Los accesos de Inicio seleccionan
la sección correspondiente sin duplicar las pantallas en el navegador.

## Cinco widgets del integrante 2

1. BotonFavorito: corazón sincronizado con el servicio.
2. TarjetaFavorito: reutiliza la tarjeta original y permite quitar favoritos.
3. EstadoVacio: icono, título y descripción; también se utiliza en Catálogo.
4. AvatarPerfil: inicial del nombre, soporte Unicode y etiqueta accesible.
5. TarjetaEstadistica: icono, título y valor reutilizables.

Junto con los cinco widgets originales del integrante 1, existen diez widgets
personalizados en lib/widgets. Se conserva la paleta suave y Material 3 del
tema existente. Las portadas reutilizan el respaldo para errores de red.

## Archivos de la segunda etapa

Nuevos: lib/screens/perfil_screen.dart, lib/screens/navegacion_screen.dart,
lib/widgets/avatar_perfil.dart, lib/widgets/tarjeta_estadistica.dart,
test/perfil_navegacion_test.dart, tools/ejecutar.ps1 y esta documentación.

Modificados: lib/main.dart (pantalla de navegación),
lib/screens/inicio_screen.dart (callbacks para seleccionar las secciones) y
lib/screens/catalogo_screen.dart (estados vacíos y errores reutilizables).

## Verificación realizada

- flutter pub get: completado con Flutter 3.44.9 / Dart 3.12.2.
- flutter analyze --no-pub: sin incidencias.
- flutter test --no-pub: 12 pruebas aprobadas (7 anteriores y 5 nuevas).
- flutter build web --release --no-pub: compilación correcta.

Las nuevas pruebas cubren validación y edición del nombre, estadísticas
reactivas con géneros únicos, navegación por las cinco pantallas conservando
la búsqueda, avatar vacío/Unicode y Perfil con texto ampliado en 320 x 480.

## Ejecutar en Windows

```powershell
cd C:\Users\camar\Downloads\gamezone-perfil
powershell -ExecutionPolicy Bypass -File .\tools\ejecutar.ps1
```

El script quita el atributo de solo lectura de las carpetas temporales de iOS
y macOS antes y después de instalar las dependencias. Corrige el bloqueo de
Flutter observado en esta instalación de Windows, sin eliminar archivos fuente.
Si tu instalación no presenta ese problema, basta con flutter pub get y
flutter run -d chrome.

## Git y revisión

La segunda etapa está en feature/perfil-navegacion y depende de
feature/favoritos (PR #2). Revisar y fusionar primero Favoritos. Después,
cambiar la base del segundo PR a main si fuera necesario y revisar Perfil y
navegación. Ningún PR se fusiona automáticamente.

Los cinco conflictos reales de práctica están documentados en
[docs/CONFLICTOS_GIT.md](docs/CONFLICTOS_GIT.md). Fueron generados y resueltos
por el asistente en ramas aisladas: no acreditan participación de dos personas.
Faltan las capturas y la actividad conjunta con el integrante 1 para completar
esa evidencia de la rúbrica. También queda la demostración individual en clase.

## Explicación para la defensa

Separé el estado de Favoritos de las pantallas mediante ChangeNotifier. Perfil
escucha el mismo servicio y calcula estadísticas desde la colección. El avatar
y las estadísticas son widgets que reciben datos por constructor. IndexedStack
conserva el estado de las secciones, mientras Navigator abre y cierra Detalle.
Reutilicé el tema, el modelo, las tarjetas y el cargador JSON del integrante 1.
Probé tanto las reglas del servicio como la interacción de las pantallas.

# Reporte final — GameZone

**Proyecto:** GameZone (catálogo de videojuegos)  
**Bina:** _[Completar: Nombre integrante 1 — Nombre integrante 2]_  
**Repositorio:** https://github.com/LuisAlexisMorales/gamezone  
**Rama de esta entrega:** `feature/api-videojuegos` (sobre `main`)  
**Fecha de entrega:** 30 de noviembre de 2026

---

## 1. Problemática y objetivo

**Problemática.** Muchas personas que juegan en distintas plataformas no tienen un lugar simple para explorar videojuegos, revisar su información clave (género, plataformas, calificación, descripción) y guardar los que les interesan.

**Objetivo.** Desarrollar una aplicación móvil/web con Flutter que permita explorar un catálogo de videojuegos consumiendo una API, consultar el detalle de cada juego, administrar favoritos y visualizar un perfil básico, con un diseño previo en Figma y documentación del proceso.

**Usuarios.** Jugadores que quieren descubrir y organizar videojuegos de forma rápida.

---

## 2. Diseño en Figma (mínimo 5 pantallas)

> **Pendiente de completar por la bina:** crear el archivo en Figma, pegar el link y exportar las capturas finales.

- **Link Figma (Figma Make):** https://www.figma.com/make/OzjR4hEX8CiofjU180JBIg/Dise%C3%B1ar-pantallas-de-GameZone?code-node-id=0-6&p=f&t=JtazEkRX8PPqLjbD-0&fullscreen=1
- **Guía de diseño:** ver `docs/FIGMA.md` (tokens, layout por pantalla, notas de API).
- **Referencias visuales generadas desde la app real:** `docs/figma/01-inicio.png` … `05-perfil.png`.

### Pantallas

| # | Pantalla | Descripción | Fuente de datos |
|---|---|---|---|
| 1 | Inicio | Bienvenida, destacados (3 juegos), accesos a Catálogo/Favoritos | `GET /videojuegos` |
| 2 | Catálogo | Búsqueda, filtro por género, lista de tarjetas, contador | `GET /videojuegos` |
| 3 | Detalle | Portada, nombre, género, calificación, plataformas, descripción, favorito | `GET /videojuegos/:id` |
| 4 | Favoritos | Lista de favoritos o estado vacío | Local/sesión (`FavoritosService`) |
| 5 | Perfil | Avatar, nombre editable, stats (favoritos, géneros únicos) | Local/sesión |

### Flujo de navegación

- Barra inferior (`IndexedStack`): Inicio ↔ Catálogo ↔ Favoritos ↔ Perfil (conserva estado).
- Inicio/Catálogo/Favoritos → Detalle (tap en tarjeta, `Navigator.push`).
- Detalle → volver (`Navigator.pop`).
- Inicio tiene accesos directos a Favoritos y Catálogo en el AppBar.

---

## 3. Arquitectura y cómo funciona

### Diagrama simple

```text
Flutter App (lib/)
  ├─ Pantallas: Inicio / Catálogo / Detalle / Favoritos / Perfil
  ├─ Servicios:  VideojuegoService  ──HTTP──▶  json-server (api-mock/db.json)
  │                                      └──fallback──▶ assets/data/videojuegos.json
  └─ Estado:     FavoritosService (ChangeNotifier, sesión)
```

### Flujo técnico (ejemplo)

1. El usuario abre **Catálogo**.
2. `CatalogoScreen` llama a `VideojuegoService.cargarVideojuegos()`.
3. El servicio intenta `GET http://localhost:3000/videojuegos` vía `VideojuegosApi` (`package:http`).
4. Si responde 200, decodifica JSON → `List<Videojuego>` y la pantalla muestra las tarjetas.
5. Si la API falla/timeout (5 s), el servicio carga `assets/data/videojuegos.json` con `rootBundle` (respaldo).
6. La pantalla maneja estados: **loading** (spinner), **error** (EstadoVacio), **vacío** (sin resultados de búsqueda/filtro), **datos** (lista).

### API mock

- Carpeta: `api-mock/` (Node + `json-server`).
- Datos: `api-mock/db.json` (misma información que el JSON local, envuelta en `{ "videojuegos": [...] }`).
- Levantar: `cd api-mock && npm install && npm run start` → `http://localhost:3000`.

---

## 4. Qué se ocupó

| Herramienta | Uso |
|---|---|
| Flutter / Dart | Desarrollo de la app (SDK ^3.12.0, Dart 3.x) |
| Figma | Diseño de las 5 pantallas y flujo (pendiente de link final) |
| VS Code / Android Studio | Edición y ejecución |
| Node.js + npm | Ejecutar la API mock |
| json-server | Servidor REST mock para el catálogo |
| Git + GitHub | Control de versiones, ramas, PRs, commits |
| PowerShell | Comandos en Windows |

---

## 5. Pasos realizados

1. **Definición:** problemática (catálogo de videojuegos) y alcance MVP.
2. **Modelo y datos:** `Videojuego` + `assets/data/videojuegos.json`.
3. **UI base:** Inicio, Catálogo, Detalle, tarjetas, tema Material 3.
4. **Favoritos:** `FavoritosService` (ChangeNotifier), pantalla, widgets y pruebas (PR #2).
5. **Perfil y navegación:** Perfil, `NavegacionScreen` con `IndexedStack`, widgets y pruebas (PR #3).
6. **API REST:** `api-mock/` con json-server; `VideojuegosApi` (http) + respaldo local; consumo en Inicio, Catálogo y Detalle; pruebas (`feature/api-videojuegos`).
7. **Diseño:** guía Figma y capturas de referencia (`docs/FIGMA.md`, `docs/figma/`).
8. **Documentación:** README, `docs/API.md`, reporte final.

---

## 6. Librerías y dónde entran

| Librería | Versión (pubspec) | Uso | Dónde se usa |
|---|---:|---|---|
| `flutter` (SDK) | sdk | Framework UI | todo `lib/` |
| `cupertino_icons` | ^1.0.8 | Iconos estilo iOS | disponible para widgets |
| `http` | ^1.2.0 | Peticiones HTTP a la API | `lib/services/videojuegos_api.dart` |
| `flutter_test` (dev) | sdk | Pruebas unitarias/widget | `test/*.dart` |
| `flutter_lints` (dev) | ^6.0.0 | Reglas de análisis estático | `analysis_options.yaml` |
| `json-server` (Node, dev) | ^0.17.4 | API REST mock | `api-mock/package.json` |

---

## 7. Códigos relevantes

### 7.1 Modelo (`lib/models/videojuego.dart`)
```dart
factory Videojuego.fromJson(Map<String, dynamic> json) {
  return Videojuego(
    id: json['id'] as int,
    nombre: json['nombre'] as String,
    genero: json['genero'] as String,
    plataforma: json['plataforma'] as String,
    calificacion: (json['calificacion'] as num).toDouble(),
    descripcion: json['descripcion'] as String,
    imagen: json['imagen'] as String,
  );
}
```

### 7.2 Cliente HTTP (`lib/services/videojuegos_api.dart`)
```dart
static const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3000',
);

Future<List<Videojuego>> fetchVideojuegos() async {
  final respuesta = await _cliente
      .get(Uri.parse('$baseUrl/videojuegos'))
      .timeout(const Duration(seconds: 5));
  if (respuesta.statusCode != 200) {
    throw Exception('Error HTTP ${respuesta.statusCode}');
  }
  final List<dynamic> datos = jsonDecode(respuesta.body) as List<dynamic>;
  return datos.map((d) => Videojuego.fromJson(d as Map<String, dynamic>)).toList();
}
```

### 7.3 Servicio con respaldo (`lib/services/videojuego_service.dart`)
```dart
Future<List<Videojuego>> cargarVideojuegos() async {
  try {
    final juegos = await _api.fetchVideojuegos(); // GET /videojuegos
    ultimaFuente = 'api';
    return juegos;
  } catch (_) {
    ultimaFuente = 'local';
    return _cargarLocal(); // assets/data/videojuegos.json
  }
}
```

### 7.4 Consumo en pantalla (patrón, `CatalogoScreen`)
```dart
late Future<List<Videojuego>> futuroVideojuegos;

@override
void initState() {
  super.initState();
  futuroVideojuegos = servicio.cargarVideojuegos(); // GET /videojuegos
}
// En build: FutureBuilder -> loading / error (EstadoVacio) / lista filtrada
```

### 7.5 Detalle consume por id (`DetalleScreen`)
```dart
Future<void> _actualizarDesdeApi() async {
  final actualizado = await _servicio.cargarVideojuegoPorId(
    _videojuego.id, respaldo: _videojuego); // GET /videojuegos/:id
  if (!mounted) return;
  setState(() => _videojuego = actualizado);
}
```

---

## 8. Pantallas donde se consume un endpoint

| Pantalla | Archivo | Endpoint | Cuándo se llama | Qué hace con la respuesta | Manejo error/vacío |
|---|---|---|---|---|---|
| Inicio | `lib/screens/inicio_screen.dart` | `GET /videojuegos` | Al construir (`FutureBuilder`/servicio) | Muestra 3 destacados y accesos | Loader; si falla, respaldo local; mensaje si vacío |
| Catálogo | `lib/screens/catalogo_screen.dart` | `GET /videojuegos` | `initState` → `cargarVideojuegos()` | Llena lista; búsqueda y filtro por género sobre la respuesta | Loader, `EstadoVacio` en error, `EstadoVacio` sin resultados |
| Detalle | `lib/screens/detalle_screen.dart` | `GET /videojuegos/:id` | `initState` → `_actualizarDesdeApi()` | Actualiza portada, nombre, género, calificación, plataformas, descripción | Si falla, conserva el objeto recibido desde la lista |

**No consumen endpoint HTTP:** Favoritos (`FavoritosService`, sesión) y Perfil (sesión).

**Prueba manual rápida:**
```powershell
cd api-mock; npm install; npm run start   # terminal 1
# terminal 2, en la raíz del repo:
flutter run -d chrome
# verificar endpoints en navegador: http://localhost:3000/videojuegos
dart run tools/probar_api.dart             # prueba CLI del consumo real
```

---

## 9. Repositorio GitHub y commits

- **Repo:** https://github.com/LuisAlexisMorales/gamezone
- **Ramas relevantes:** `main`, `feature/favoritos`, `feature/perfil-navegacion`, `feature/api-videojuegos`.
- **PRs:** #1 modelo, #2 favoritos, #3 perfil/navegación; pendiente PR de `feature/api-videojuegos`.

### Commits destacados (recientes)

| Commit | Mensaje | Aporte |
|---|---|---|
| `8fc0536` | `feat(api): agregar API REST mock con json-server...` | `api-mock/db.json`, `package.json`, lock |
| `daf8e6b` | `feat(app): consumir GET /videojuegos y GET /videojuegos/:id...` | `VideojuegosApi`, http, servicio con fallback, Detalle por id, tests |
| `7f5876a` | `docs: documentar la API, endpoints por pantalla...` | README, `docs/API.md` |
| `89e4766` | `Completar perfil y navegación...` | Perfil, navegación, widgets, pruebas |
| `4d85096` | `Implementar favoritos compartidos...` | FavoritosService, pantalla, widgets |

> Ejecuta `git log --oneline --graph -n 15` para la vista actualizada.

---

## 10. Pruebas y verificación

Ejecutado en esta entrega:

```powershell
flutter pub get
flutter analyze --no-pub   # No issues found
flutter test --no-pub      # 18 tests passed (12 existentes + 6 API)
flutter build web --release --no-pub  # Built build\web
dart run tools/probar_api.dart        # GET /videojuegos -> 6; GET /videojuegos/1 OK
```

Las pruebas de API (`test/api_test.dart`) usan `MockClient` de `package:http/testing.dart` para simular respuestas HTTP y validar parseo, errores y fallback local.

---

## 11. Conclusiones y mejoras futuras

**Conclusiones.** GameZone cumple el flujo base de una app de catálogo: diseño (guía + referencia), navegación por 5 pantallas, consumo real de endpoints REST (`GET /videojuegos`, `GET /videojuegos/:id`), manejo de loading/error/vacío, favoritos en sesión y documentación con commits.

**Mejoras futuras.**
- Persistir favoritos/perfil en almacenamiento local (`shared_preferences`/SQLite).
- Autenticación y favoritos por usuario.
- Paginación/búsqueda en servidor (`json-server` ya soporta `?q=` y `_page`).
- Deploy de la API mock a un servicio público para que la app funcione sin localhost.
- Pruebas de integración end-to-end con la app corriendo contra json-server.

---

## Anexos / pendientes para cerrar entrega

- [x] Pegar **link de Figma** en la sección 2.
- [ ] Completar nombres de la **bina** en portada.
- [ ] Exportar capturas Figma finales a `docs/figma/` (o enlazarlas).
- [ ] Crear PR de `feature/api-videojuegos` → `main` y fusionar si el equipo lo aprueba.
- [ ] Revisar que el repo sea accesible para el docente.
- [ ] (Opcional) Agregar capturas de la app corriendo y del endpoint en navegador/Postman.

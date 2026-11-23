# API de GameZone (mock con json-server)

GameZone consume una API REST para cargar el catálogo de videojuegos.
La API se implementa con [json-server](https://github.com/typicode/json-server)
sobre el mismo catálogo que antes vivía solo en `assets/data/videojuegos.json`.

## Levantar la API

Requisitos: Node.js y npm.

```powershell
cd api-mock
npm install
npm run start
```

El servidor queda en `http://localhost:3000` con estos endpoints:

| Método | Endpoint | Respuesta |
|---|---|---|
| GET | `/videojuegos` | Lista completa de videojuegos (JSON) |
| GET | `/videojuegos/:id` | Un videojuego por id (JSON) |
| GET | `/videojuegos?genero=RPG` | Filtrado por género (lo hace el servidor) |
| GET | `/videojuegos?q=zelda` | Búsqueda de texto (lo hace el servidor) |

Ejemplo de respuesta de `GET /videojuegos/1`:

```json
{
  "id": 1,
  "nombre": "Minecraft",
  "genero": "Sandbox",
  "plataforma": "PC, Consolas, Móvil",
  "calificacion": 9.0,
  "descripcion": "Explora mundos, construye estructuras y sobrevive utilizando tu creatividad.",
  "imagen": "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/2399830/header.jpg"
}
```

## URL base según la plataforma

La app usa `http://localhost:3000` por defecto. Se puede cambiar al compilar
con `--dart-define=API_BASE_URL=...`:

| Plataforma | URL base | Comando |
|---|---|---|
| Web (Chrome) / Windows | `http://localhost:3000` | `flutter run -d chrome` |
| Emulador Android | `http://10.0.2.2:3000` | `flutter run -d emulator-5554 --dart-define=API_BASE_URL=http://10.0.2.2:3000` |
| Dispositivo físico | `http://<IP-de-tu-PC>:3000` | `flutter run --dart-define=API_BASE_URL=http://192.168.x.x:3000` |

## Pantallas que consumen un endpoint

| Pantalla | Endpoint | Cuándo se llama | Qué hace con la respuesta | Manejo de error |
|---|---|---|---|---|
| Inicio (`lib/screens/inicio_screen.dart`) | `GET /videojuegos` | Al construir la pantalla (`FutureBuilder`) | Toma los 3 primeros como "Juegos destacados" | Loader mientras carga; si la API falla, respaldo con el JSON local |
| Catálogo (`lib/screens/catalogo_screen.dart`) | `GET /videojuegos` | Al entrar (`initState`) | Llena la lista; búsqueda y filtro por género sobre los datos recibidos | Loader, estado de error y estado vacío |
| Detalle (`lib/screens/detalle_screen.dart`) | `GET /videojuegos/:id` | Al abrir la pantalla (`initState`) | Actualiza portada, nombre, género, calificación, plataformas y descripción | Si falla, conserva el objeto recibido desde la lista |

Favoritos y Perfil no consumen endpoints: usan `FavoritosService`
(estado local de sesión con `ChangeNotifier`).

## Código clave

- `lib/services/videojuegos_api.dart`: cliente HTTP (`package:http`).
  Hace `GET`, valida el código de estado, decodifica JSON y mapea al
  modelo `Videojuego`. Tiempo límite de 5 segundos por petición.
- `lib/services/videojuego_service.dart`: orquesta la carga. Primero
  intenta la API; si falla (servidor apagado, sin red, timeout), carga
  `assets/data/videojuegos.json` con `rootBundle` como respaldo. Expone
  `ultimaFuente` (`'api'` o `'local'`) para saber de dónde vinieron los datos.
- `lib/models/videojuego.dart`: modelo con `Videojuego.fromJson`.

## Respaldo local (importante para la defensa)

Si json-server no está corriendo, la app **sigue funcionando** con el JSON
local empaquetado. Para demostrar el consumo real del endpoint en clase:

1. Levantar la API (`cd api-mock && npm run start`).
2. Correr la app (`flutter run -d chrome`).
3. Mostrar en el navegador `http://localhost:3000/videojuegos` y explicar
   que Inicio/Catálogo reciben esa misma respuesta.
4. Apagar el servidor y recargar: la app sigue mostrando el catálogo
   gracias al respaldo local (resiliencia).

## Pruebas

`test/api_test.dart` cubre el cliente HTTP con un cliente simulado
(`MockClient` de `package:http/testing.dart`): parseo de lista y de detalle,
errores HTTP, uso de la API cuando responde y respaldo local cuando falla.

```powershell
flutter test
```

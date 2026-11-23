# GameZone

Aplicación Flutter para explorar un catálogo de videojuegos: ver destacados,
buscar y filtrar por género, consultar el detalle, guardar favoritos y
administrar un perfil básico. Proyecto en binas — entrega 30 de noviembre de 2026.

## Pantallas (5)

1. **Inicio** — destacados y accesos rápidos.
2. **Catálogo** — búsqueda, filtro por género y lista de tarjetas.
3. **Detalle** — portada, calificación, plataformas y descripción.
4. **Favoritos** — colección de sesión con estado vacío.
5. **Perfil** — nombre editable, avatar y estadísticas.

Navegación inferior con `IndexedStack` (Inicio, Catálogo, Favoritos, Perfil);
Detalle se abre con `Navigator` desde cualquier tarjeta.

## API

El catálogo se consume por HTTP desde una API mock (json-server):
`GET /videojuegos` y `GET /videojuegos/:id`. Si el servidor no está
disponible, la app usa el JSON local como respaldo.

```powershell
cd api-mock
npm install
npm run start   # http://localhost:3000
```

Detalles, endpoints por pantalla y URLs según plataforma: [docs/API.md](docs/API.md).

## Ejecutar la app

Requisitos: Flutter (SDK ^3.12.0) y, para la API, Node.js.

```powershell
flutter pub get
flutter run -d chrome
```

En emulador Android, apunta la app al host de la máquina anfitriona:

```powershell
flutter run -d emulator-5554 --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

## Verificar

```powershell
flutter analyze
flutter test
flutter build web --release
```

## Documentación del proyecto

- [docs/API.md](docs/API.md) — API, endpoints y pantallas que los consumen.
- [FAVORITOS.md](FAVORITOS.md) — módulo de favoritos (integrante 2).
- [INTEGRANTE_2.md](INTEGRANTE_2.md) — entrega de perfil y navegación.
- [docs/CONFLICTOS_GIT.md](docs/CONFLICTOS_GIT.md) — práctica de conflictos.

# Guía de diseño para Figma — GameZone

> Objetivo: crear **mínimo 5 pantallas** del proyecto GameZone en Figma.
> Las capturas de referencia en `docs/figma/*.png` (si existen) o la app real
> (`flutter run -d chrome`) sirven como base visual. Esta guía define el
> contenido, layout y notas de API de cada pantalla.

## Identidad visual (tomada del código)

| Token | Valor | Uso |
|---|---|---|
| Fondo | `#F4F6FA` | scaffold / fondo de pantalla |
| Principal (navy) | `#24364B` | AppBar, chips seleccionados, textos fuertes |
| Acento (teal) | `#4F9D91` | botones filled, items activos, chips de género |
| Superficie | `#FFFFFF` | tarjetas, campos de texto |
| Bordes tarjetas | radio 16 | `CardTheme` |
| Bordes inputs | radio 14 | `InputDecorationTheme` |
| Tipografía | Roboto / Material 3 | por defecto en Flutter |

## Referencias visuales (generadas desde la app real)

En `docs/figma/` hay 5 capturas generadas con la app (tema y datos reales)
que puedes usar como referencia para reproducir el diseño en Figma:

- `docs/figma/01-inicio.png`
- `docs/figma/02-catalogo.png`
- `docs/figma/03-detalle.png`
- `docs/figma/04-favoritos.png`
- `docs/figma/05-perfil.png`

> Nota: estas capturas son una referencia rápida; la entrega pide el **diseño
> en Figma** (frames + flujo + link). Reprodúcelas en Figma y agrega el link
> en el reporte.

## Frame base en Figma

- Dispositivo: iPhone 13/14 (390 × 844) o Android similar.
- Crea un **frame por pantalla** + 1 frame de **flujo/navegación**.
- Nombra los frames: `01 Inicio`, `02 Catálogo`, `03 Detalle`, `04 Favoritos`, `05 Perfil`, `00 Flujo`.

## Pantalla 1 — Inicio
**Fuente de datos:** `GET /videojuegos` (carga al entrar; toma 3 destacados).

- AppBar navy: título `GameZone`, iconos derecha: corazón (ir a Favoritos), grid (ir a Catálogo).
- Título grande: "Descubre tu próximo juego".
- Subtítulo gris: "Explora aventuras, mundos y nuevas experiencias."
- Sección "Juegos destacados" + enlace "Ver catálogo".
- 3 tarjetas verticales: portada (izq), nombre, chip de género (teal claro), estrella ámbar + calificación.
- Botón filled teal ancho completo: "Explorar todos los juegos".
- Bottom nav (4): Inicio **activo** (teal), Catálogo, Favoritos, Perfil.
- Nota Figma: `Consume GET /videojuegos al construir la pantalla (FutureBuilder). Loader / error / vacío.`

## Pantalla 2 — Catálogo
**Fuente de datos:** `GET /videojuegos` (al entrar, `initState`). **Pantalla clave de endpoint.**

- AppBar navy: "Catálogo".
- Campo búsqueda blanco con icono lupa: "Buscar videojuego...".
- Chips horizontales: `Todos` (seleccionado, navy), géneros del catálogo.
- Texto: "6 videojuegos encontrados" (dinámico).
- Lista de tarjetas (imagen, nombre, chip género, calificación).
- Estados a mostrar en notas/variantes: **loading** (spinner), **error** (EstadoVacio con icono error), **vacío** ("No se encontraron videojuegos").
- Bottom nav: Catálogo **activo**.
- Nota Figma: `GET http://localhost:3000/videojuegos` → llena lista. Búsqueda/filtro en cliente sobre la respuesta.

## Pantalla 3 — Detalle
**Fuente de datos:** `GET /videojuegos/:id` (al abrir; respaldo = objeto recibido desde la lista).

- AppBar navy: flecha atrás, "Detalle del videojuego", icono corazón (favorito).
- Portada grande redondeada (altura ~220).
- Nombre grande, chip de género.
- Card "Calificación" con estrella ámbar y valor (ej. 9.5).
- Card "Plataformas" con icono dispositivos.
- Título "Descripción" + párrafo.
- Botón filled teal: "Volver al catálogo".
- Sin bottom nav (es pantalla apilada por Navigator).
- Nota Figma: `GET /videojuegos/:id al initState. Si falla, conserva el videojuego recibido desde la lista.`

## Pantalla 4 — Favoritos
**Fuente de datos:** local/sesión (`FavoritosService`, `ChangeNotifier`). **No consume endpoint.**

- AppBar navy: "Favoritos".
- Variante A (vacío): icono corazón grande, "Todavía no tienes favoritos", "Agrega juegos con el corazón desde su detalle y aparecerán aquí.", botón "Explorar catálogo".
- Variante B (con items): lista de tarjetas con botón para quitar favorito.
- Bottom nav: Favoritos **activo**.
- Nota Figma: `Estado local de sesión (FavoritosService). Sin endpoint HTTP.`

## Pantalla 5 — Perfil
**Fuente de datos:** local/sesión. **No consume endpoint.**

- AppBar navy: "Perfil".
- Avatar circular teal con inicial del nombre.
- Nombre (ej. "Luis") + icono lápiz (editable) + caption "Nombre editable".
- Dos tarjetas de estadística: "Favoritos" (número) y "Géneros únicos" (número).
- Card informativa: "Los datos se guardan durante la sesión".
- Bottom nav: Perfil **activo**.
- Nota Figma: `Datos locales de sesión. Nombre editable, stats calculadas desde FavoritosService.`

## Frame 0 — Flujo de navegación

Dibuja flechas:
- Bottom nav: Inicio ↔ Catálogo ↔ Favoritos ↔ Perfil (IndexedStack, conserva estado).
- Inicio → Detalle (tap en tarjeta). Catálogo → Detalle. Favoritos → Detalle.
- Detalle → atrás (pop).
- Anota junto a Catálogo/Inicio/Detalle el endpoint correspondiente.

## Checklist Figma para la entrega
- [ ] 5 pantallas (frames) creadas.
- [ ] Flujo de navegación visible.
- [ ] Cada pantalla tiene nota de fuente de datos (API o local).
- [ ] Pantallas con endpoint marcadas claramente (Catálogo, Inicio, Detalle).
- [ ] Link de Figma compartido (cualquier persona con el enlace puede ver).
- [ ] Capturas PNG exportadas en `docs/figma/` o enlazadas en el reporte.

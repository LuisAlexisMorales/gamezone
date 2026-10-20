# Cinco conflictos reales de práctica

Estos conflictos se provocaron y resolvieron con Git en un worktree separado,
en la rama evidencia/conflictos. Son ejercicios realizados por el asistente
con la identidad Git configurada de al3-dan. No representan colaboración ni
commits del integrante 1. No se fusionaron en main ni en las ramas funcionales.

Cada caso tiene dos ramas desde una base común. Ambas cambian la misma línea;
git merge devuelve código 1 y un conflicto de contenido. Se guardaron el estado
UU, el diff combinado, los marcadores y los hashes reales de ambos commits y
del commit de resolución. La resolución conserva el valor de producción.
La comparación final con feature/perfil-navegacion no muestra cambios.

| Caso | Archivo | Diferencias | Registro |
| --- | --- | --- | --- |
| 1 | lib/main.dart | Dos títulos para la app | [conflicto-1.txt](evidencias-git/conflicto-1.txt) |
| 2 | lib/theme/app_theme.dart | Dos colores de acento | [conflicto-2.txt](evidencias-git/conflicto-2.txt) |
| 3 | lib/screens/navegacion_screen.dart | Dos etiquetas de Inicio | [conflicto-3.txt](evidencias-git/conflicto-3.txt) |
| 4 | lib/widgets/tarjeta_estadistica.dart | Dos márgenes del widget | [conflicto-4.txt](evidencias-git/conflicto-4.txt) |
| 5 | assets/data/videojuegos.json | Dos nombres del mismo juego | [conflicto-5.txt](evidencias-git/conflicto-5.txt) |

El quinto ejercicio modifica el mismo dato JSON; no cambia su esquema. Si el
profesor exige un conflicto de estructura específicamente, realizar ese caso
con el compañero y probar el modelo/cargador después de resolverlo.

## Consultar evidencia reproducible

```powershell
git fetch origin
git log --graph --oneline origin/evidencia/conflictos
git show --remerge-diff 4363522
git show --remerge-diff f9a69d2
git show --remerge-diff 77f0378
git show --remerge-diff b59a107
git show --remerge-diff 8e484c4
```

Git remerge-diff reconstruye los conflictos de esos merges para inspeccionar
los marcadores y la resolución. Los archivos .txt son registros textuales,
no capturas de pantalla.

## Evidencia conjunta pendiente

Coordinar cinco casos con el compañero en ramas de práctica nuevas. Cada uno
debe realizar y subir su propio cambio desde la misma base. Antes de fusionar,
guardar sus hashes; al aparecer el conflicto, capturar la terminal con git
status y el editor con los marcadores. Resolver juntos, guardar un commit de
merge y capturar el resultado sin conflictos. Documentar participantes,
decisión de resolución y verificación. No atribuir estos ejercicios automáticos
al compañero ni presentar capturas reconstruidas como actividad conjunta.

Al terminar, incorporar las capturas y los hashes de la actividad conjunta en
este documento y revisar con el profesor que cumplen la rúbrica original.

# Guía de contribución

## Ramas

| Rama | Uso |
|---|---|
| `main` | Versión entregable. Solo recibe merges desde `develop` al cerrar un sprint. |
| `develop` | Integración. Aquí se acumulan los cambios del sprint. |
| `docs/<sección>-<tema>` | Trabajo en una sección. Ejemplo: `docs/04-matriz-riesgo`. |
| `fix/<tema>` | Corrección de errores de contenido o de compilación. |
| `ci/<tema>` | Cambios en workflows, Makefile o scripts. |

## Flujo

1. Crear la rama desde `develop` actualizado.
2. Hacer commits pequeños y abrir un PR hacia `develop`.
3. Esperar el CI en verde y la revisión de al menos un compañero.
4. Al cerrar el sprint, abrir un PR de `develop` a `main`.
5. Crear el tag de la entrega (`v0.1-sprint1`, `v0.2-sprint2`, `v1.0-midterm`). El CI publica el PDF en el Release.

## Commits

Formato: `tipo(alcance): descripción en presente`.

Tipos: `docs`, `fix`, `style`, `build`, `ci`, `chore`.

Ejemplos:

- `docs(04): add traceability rows for sprint 1`
- `fix(05): correct SHA of sprint 2 analysis`
- `ci: pin texlive image`

## Reglas de escritura

- El informe se escribe en inglés. Este README y esta guía pueden estar en español.
- Una oración por línea en los `.tex`, para que los diffs y los conflictos sean pequeños.
- Los datos del equipo y del proyecto se cambian solo en `config/metadata.tex`.
- Para imágenes del informe usar `\evidencefigure{carpeta/archivo.png}{Caption.}{fig:etiqueta}`.
- Tablas con `tabularx` o `longtable` y estilo `booktabs`, sin líneas verticales.

## Evidencias

- Los archivos originales (PDF de ejecuciones del CI, `junit.xml`, formularios) van en `evidence/sprintN/`.
- Nombre: `EV-S<sprint>-<nn>_<descripcion>.<ext>`. Ejemplo: `EV-S1-03_ci-run-41928519922.pdf`.
- Cada evidencia se cita en la sección del informe que la usa, con fecha y tag o SHA.
- Las capturas que se muestran en el informe van en `figures/<sección>/`.
- Nunca subir credenciales, tokens ni variables de entorno reales.

## Agregar un sprint

1. Copiar `sprint2.tex` a `sprint3.tex` en `sections/03_sprints/`, `sections/05_static_analysis/` y `sections/06_test_execution/`.
2. Ajustar títulos, etiquetas y nombres de figuras.
3. Agregar la línea `\input{...}` en el archivo padre de cada carpeta.

## Entregar

1. Ajustar `config/metadata.tex` (número de equipo, nombres, fecha, enlace del video).
2. Ejecutar `make pdf check lint` en local.
3. Verificar que el archivo se llame `T<número><Proyecto>_Midterm.pdf` (`make name`).

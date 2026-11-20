# Leodega – Documentación del Midterm Project

Informe del Midterm Project de Ingeniería de Software II (Sprints 1 y 2), escrito en LaTeX y compilado automáticamente a PDF.

## Requisitos locales

- TeX Live con `latexmk` y `pdflatex`
- `make`
- `chktex` (opcional, para el linter)

## Comandos

| Comando | Qué hace |
|---|---|
| `make pdf` | Compila el informe en `build/` |
| `make watch` | Recompila al guardar |
| `make check` | Verifica que el PDF exista y que no haya referencias indefinidas |
| `make lint` | Revisa el estilo de los `.tex` con ChkTeX |
| `make name` | Muestra el nombre del PDF final |
| `make clean` | Borra `build/` |

El PDF se llama `T<número><Proyecto>_Midterm.pdf`. Ambos datos se leen de `config/metadata.tex`.

## Estructura

```
.
├── main.tex                    Documento raíz: solo ensambla
├── config/metadata.tex         Datos del equipo, cliente y proyecto
├── preamble/
│   ├── packages.tex            Paquetes
│   ├── macros.tex              Macros y comandos propios
│   └── style.tex               Estilo visual, encabezados, enlaces
├── sections/
│   ├── 00_cover.tex … 11_presentation_video.tex
│   ├── 03_sprints/             sprint1.tex, sprint2.tex
│   ├── 05_static_analysis/     sprint1.tex, sprint2.tex
│   └── 06_test_execution/      sprint1.tex, sprint2.tex
├── appendices/                 Anexo A (instalación y despliegue)
├── figures/                    Imágenes incluidas en el informe, por sección
├── evidence/                   Archivos originales de evidencia, por sprint
├── presentation/               Guion del video
├── scripts/                    jobname.sh y gitinfo.sh
├── .github/                    Workflow de CI y plantilla de PR
├── Makefile, .latexmkrc        Compilación
└── .editorconfig, .chktexrc    Estilo y linter
```

## Flujo de trabajo

Rama por tarea → PR a `develop` → merge de `develop` a `main` al cerrar el sprint → tag para publicar el PDF. Los detalles están en [CONTRIBUTING.md](CONTRIBUTING.md).

## CI/CD

El workflow `.github/workflows/build.yml` se ejecuta en cada push y PR hacia `main` y `develop`:

1. `lint`: revisa los `.tex` con ChkTeX.
2. `pdf`: compila con `make pdf` y verifica con `make check` dentro de una imagen oficial de TeX Live. Sube el PDF como artefacto.
3. `release`: al subir un tag `v*`, publica el PDF en un GitHub Release.

El pie de página de cada PDF muestra el SHA del commit y la fecha de compilación.

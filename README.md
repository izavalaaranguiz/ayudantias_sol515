# Ayudantías Modelos de Regresión (SOL515) 🖥️​

📚​ En este repositorio podrás encontrar el material de mis ayudantías del curso *Modelos de Regresión* (SOL515) para 3er año de Sociología.

![](memelm.png)





#
## Ayudantía 1 — Regresión Lineal Simple 📈​

📝 Primera aproximación a la regresión lineal simple: sus fundamentos conceptuales
(componentes del modelo, estimador OLS, interpretación de intercepto y coeficiente)
y su aplicación práctica en `RStudio` (exploración de datos, estimación con `lm()`,
lectura de `summary()`, cálculo de valores predichos y visualización de resultados).

[Ayudantía 1 — Regresión Lineal Simple](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia1/ayudantia1_mrl.html)

#
## Ayudantía 2 — Regresión Lineal Múltiple e Intervalos de Confianza 📊

📝 Aplicación de la regresión lineal múltiple en `RStudio`: preparación de
los datos, estimación de modelos y lectura de `summary()`,
interpretación de coeficientes, estimación e interpretación de
intervalos de confianza al 95% y gráfico de coeficientes.

Caso: ¿qué se asocia con las visitas de un video de YouTube? (datos simulados).

[Ayudantía 2 — Regresión Lineal Múltiple](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia2/ayudantia2_mrl.html)


### 📂 Cómo cargar la base de datos 

La base `viral_videos.csv` (12.000 videos simulados, [fuente original en Kaggle](https://www.kaggle.com/datasets/vedauv/what-makes-a-yt-video-go-viral-12000-vids/data)) se puede cargar en `RStudio` de dos formas:

### Opción 1: desde el computador

1. Descargar el archivo presionando [aquí](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia2/viral_videos.csv)
2. Guardar en **la misma carpeta del script**.
3. En `RStudio`, indicar esa carpeta como directorio de trabajo: menú *Session → Set Working Directory → To Source File Location*.
4. Carga la base:

```r
videos <- read.csv("viral_videos.csv")
```

### Opción 2: directo desde GitHub (sin descargar nada)

Carga la base con el link directo al archivo pegando esto en tu script de `RStudio`:

```r
videos <- read.csv("https://raw.githubusercontent.com/izavalaaranguiz/ayudantias_sol515/main/ayudantia2/viral_videos.csv")
```

#
## Ayudantía 3 — Preparación Ejercicio 1 🔎

📝 Comentarios generales para resolver el [Ejercicio 1](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/Ejercicio1_2026.pdf), basado en el paper de
[Bautista et al. (2023)](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/bautista2021.pdf):
idea general del argumento, preguntas guía para la lectura y preparación de la base de datos
(filtro de la muestra con `MainSample` y uso del ponderador `Pop70` en `lm()`).

Luego, un ejercicio de aplicación con el paper de Homola et al. (2020): estimación de modelos
de regresión múltiple, regresión con valores predichos, test F con `library(car)` y exportación de tablas de calidad a Word con `library(texreg)`.

> Homola, J., Pereira, M. M., & Tavits, M. (2020). Legacies of the Third Reich: Concentration camps and out-group intolerance. *American Political Science Review, 114*(2), 573–590. https://doi.org/10.1017/S0003055419000832

[Ayudantía 3 — Preparación Ejercicio 1](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/ayudantia3_mrl.html)

[Paper de Homola et al. (2020)](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/Homola20.pdf)


### 📂 Cómo cargar las bases de datos

Usaremos dos bases:

- `FinalDatasetForReplicationStata12.dta`: datos de Bautista et al. (2023), en formato Stata, que se carga con el paquete `foreign`.
- `EVS_main.csv`: datos de Homola et al. (2020), de la European Values Survey (2008).

### Opción 1: desde el computador

1. Descargar los archivos presionando [aquí (Bautista)](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/FinalDatasetForReplicationStata12.dta) y [aquí (Homola)](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia3/EVS_main.csv)
2. Guardarlos en **la misma carpeta del script**.
3. En `RStudio`, indicar esa carpeta como directorio de trabajo: menú *Session → Set Working Directory → To Source File Location*.
4. Cargar las bases:

```r
library(foreign)   # Para leer bases de Stata: read.dta()

data <- read.dta("FinalDatasetForReplicationStata12.dta")   # Bautista et al. (2023)
evs  <- read.csv("EVS_main.csv")                            # Homola et al. (2020)
```

### Opción 2: directo desde GitHub (sin descargar nada)

Cargar las bases con el link directo a los archivos pegando esto en tu script de `RStudio`:

```r
library(foreign)

data <- read.dta("https://raw.githubusercontent.com/izavalaaranguiz/ayudantias_sol515/main/ayudantia3/FinalDatasetForReplicationStata12.dta")
evs  <- read.csv("https://raw.githubusercontent.com/izavalaaranguiz/ayudantias_sol515/main/ayudantia3/EVS_main.csv")
```

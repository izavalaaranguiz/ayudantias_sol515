# Ayudantías Modelos de Regresión (SOL515) 🖥️​

📚​ En este repositorio podrás encontrar el material de mis ayudantías del curso *Modelos de Regresión* (SOL515) para 3er año de Sociología.

![](memelm.png)

## Ayudantía 1 — Regresión Lineal Simple 📈​

📝 Primera aproximación a la regresión lineal simple: sus fundamentos conceptuales
(componentes del modelo, estimador OLS, interpretación de intercepto y coeficiente)
y su aplicación práctica en `RStudio` (exploración de datos, estimación con `lm()`,
lectura de `summary()`, cálculo de valores predichos y visualización de resultados).

[Ayudantía 1 — Regresión Lineal Simple](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia1/ayudantia1_mrl.html)


## Ayudantía 2 — Regresión Lineal Múltiple 📊

📝 Aplicación de la regresión lineal múltiple en `RStudio`: preparación de
los datos, estimación de modelos y lectura de `summary()`,
interpretación de coeficientes, estimación e interpretación de
intervalos de confianza al 95% y gráfico de coeficientes.

Caso: ¿qué se asocia con las visitas de un video de YouTube? (datos simulados).

[Ayudantía 2 — Regresión Lineal Múltiple](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia2/ayudantia2_mrl.html)


### 📂 Cómo cargar la base de datos 

La base `viral_videos.csv` (12.000 videos simulados, [fuente original en Kaggle](https://www.kaggle.com/datasets/vedauv/what-makes-a-yt-video-go-viral-12000-vids/data), licencia CC0) se puede cargar en `RStudio` de dos formas. Elige la que te acomode:

### Opción 1: desde tu computador

1. Descarga el archivo presionando [aquí](https://izavalaaranguiz.github.io/ayudantias_sol515/ayudantia2/viral_videos.csv)
2. Guárdalo en **la misma carpeta de tu script**.
3. En `RStudio`, indica esa carpeta como directorio de trabajo: menú *Session → Set Working Directory → To Source File Location*.
4. Carga la base:

```r
videos <- read.csv("viral_videos.csv")
```

### Opción 2: directo desde GitHub (sin descargar nada)

Necesitas conexión a internet. Carga la base con el link directo al archivo pegando esto en tu script de `RStudio`:

```r
videos <- read.csv("https://raw.githubusercontent.com/izavalaaranguiz/ayudantias_sol515/main/ayudantia2/viral_videos.csv")
```

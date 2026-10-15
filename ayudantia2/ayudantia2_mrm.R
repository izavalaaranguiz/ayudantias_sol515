################################################################################
# Ayudantía 2 — Regresión Lineal Múltiple
# Modelos de Regresión (SOL515) - Ignacio Zavala Aránguiz
#
# Contenidos:
#   1. Interpretación de coeficientes y bondad del ajuste
#   2. Estimación e interpretación de intervalos de confianza
#   3. Presentación de resultados en una tabla de calidad
#   4. Gráfico de intervalos de confianza
#   Apéndice: error estándar de la regresión y de un coeficiente
#
# Pregunta: ¿qué características de un video de YouTube se asocian con su
# número de visitas?
#
# Datos: "What Makes a Video Go Viral?" (Kaggle, CC0). 12.000 videos
################################################################################


# 0. Preparación

rm(list = ls())        # Limpiamos el entorno
options(scipen = 999)  # Quitamos la notación científica

# install.packages(c("texreg", "car", "coefplot"))  # Solo la primera vez
library(texreg)    # Tablas de regresión: screenreg(), htmlreg()
library(car)       # Intervalos de confianza: Confint()
library(coefplot)  # Gráfico de coeficientes: coefplot()

# Cargamos la base (el .csv debe estar en la misma carpeta que este script)
videos <- read.csv("viral_videos.csv")

head(videos[, c("views", "duration_sec", "title_length", "subscriber_count")], n = 10)
dim(videos)   # 12.000 videos y 15 variables


# 1. Exploración y preparación de los datos (R base) ---------------------------

# 1.1 Variable dependiente: visitas ------------------------------------------
summary(videos$views)
# La media (767.752) es mucho mayor que la mediana (185.268): unos pocos
# videos con millones de visitas tiran la media hacia arriba.

hist(videos$views, breaks = 100,
     main = "Visitas por video", xlab = "Visitas")

# Igual que en la ayudantía 1, dejamos fuera los casos extremos:
# nos quedamos con los videos de hasta 1 millón de visitas.
videos <- videos[videos$views <= 1000000, ]
nrow(videos)   # 10.161 videos

# Expresamos las visitas en MILES para que los coeficientes sean legibles
videos$visitas <- videos$views / 1000
summary(videos$visitas)

hist(videos$visitas, breaks = 50,
     main = "Visitas por video (menos de 1 millón)", xlab = "Visitas (miles)")


# 1.2 Predictores continuos ---------------------------------------------------

# Duración: viene en segundos, la pasamos a minutos
videos$duracion <- videos$duration_sec / 60
summary(videos$duracion)

# Largo del título: número de caracteres
videos$largo_titulo <- videos$title_length
summary(videos$largo_titulo)

# Suscriptores del canal: los pasamos a decenas de miles
videos$suscriptores <- videos$subscriber_count / 10000
summary(videos$suscriptores)


# 2. Estimación de modelos -----------------------------------------------------

# Estimamos modelos que van sumando predictores (como en clases)
m1 <- lm(visitas ~ duracion, data = videos)
m2 <- lm(visitas ~ duracion + largo_titulo, data = videos)
m3 <- lm(visitas ~ duracion + largo_titulo + suscriptores, data = videos)

summary(m3)
# Por ahora nos fijamos SOLO en la columna "Estimate" y en las líneas
# finales (Residual standard error y R-squared).

# Comparamos los tres modelos lado a lado
screenreg(l = list(m1, m2, m3),
          single.row = FALSE,
          stars = numeric(0),
          )

# ¿Qué pasa con el coeficiente de duración entre m1 y m3?
coef(m1)["duracion"]
coef(m3)["duracion"]
# Pasa de -6,1 a -2,1: parte de la asociación negativa entre duración y
# visitas se debe al tamaño del canal: los videos más largos tienden a estar
# en canales más pequeños. Al controlar por suscriptores, el coeficiente cambia.
cor(videos$duracion, videos$suscriptores)


# 3. Interpretación de coeficientes (modelo m3) --------------------------------

coef(m3)

# (Intercept) = 143,09: visitas esperadas (en miles): para un video de 0 minutos,
#   título de 0 caracteres y canal con 0 suscriptores, se esperan 143.090 visitas.
#   Es un valor de referencia, sin interpretación sustantiva por sí solo.
#
# duracion = -2,07: por cada minuto adicional de duración, el número esperado
#   de visitas disminuye en 2.070 aprox., manteniendo constantes el largo del
#   título y los suscriptores del canal (ceteris paribus).
#
# largo_titulo = 0,27: por cada caracter adicional en el título, las visitas
#   esperadas aumentan en 270 aprox., manteniendo constante el resto.
#
# suscriptores = 1,69: por cada 10.000 suscriptores adicionales del canal, las
#   visitas esperadas aumentan en 1.690 aprox., manteniendo constante el resto.


# 4. Bondad del ajuste ---------------------------------------------------------

summary(m3)$r.squared       # R²
summary(m3)$adj.r.squared   # R² ajustado (penaliza por cada predictor extra)

# Interpretación: el modelo explica cerca de un 28% de la varianza de las
# visitas. El 72% restante depende de factores que no incluimos.

# ¿Cuánto mejora el ajuste al ir sumando predictores?
summary(m1)$r.squared
summary(m2)$r.squared
summary(m3)$r.squared
# Casi todo el salto viene de los suscriptores: el tamaño del canal.


# 5. Intervalos de confianza ---------------------------------------------------

# 5.1 Con funciones de R --------------------------------------------------------
confint(m3)   # R base
Confint(m3)   # Paquete car: agrega la columna con el coeficiente

# Interpretación (duración): con un 95% de confianza, por cada minuto
# adicional las visitas esperadas disminuyen entre 1.200 y 2.900 aprox.,
# manteniendo constante el resto de las variables.
#
# Interpretación (largo del título): el intervalo va de 0,02 a 0,53: son
# valores positivos pero muy cercanos a 0, una asociación pequeña.
#
# Interpretación (suscriptores): por cada 10.000 suscriptores adicionales las
# visitas esperadas aumentan entre 1.640 y 1.750 aprox. Intervalo angosto:
# estimación muy precisa.
#
# Recordar: si repitiéramos el muestreo muchas veces, el 95% de los
# intervalos construidos así contendría el verdadero valor poblacional.

# 5.2 A mano --------------------------------------------------------------------
# IC: b_j ± c * se(b_j), con c = t(alfa/2, n-k-1)

n <- nobs(m3)                   # número de observaciones
k <- length(coef(m3)) - 1       # número de predictores (sin el intercepto)

b_dur  <- coef(m3)["duracion"]
se_dur <- summary(m3)$coefficients["duracion", "Std. Error"]

# A mano con 1,96 (distribución normal)
b_dur - 1.96 * se_dur   # Límite inferior
b_dur + 1.96 * se_dur   # Límite superior

# A mano con la distribución t
t_val <- qt(0.975, n - k - 1)
t_val   # 1,96: con n grande, t y normal prácticamente coinciden
        # (en la clase, con n = 15, el valor t era 2,20)

b_dur - t_val * se_dur  # Límite inferior
b_dur + t_val * se_dur  # Límite superior

confint(m3)["duracion", ]   # Comparamos con confint()


# 6. Tabla de calidad ----------------------------------------------------------

# Con coeficientes e IC, nombres en español
screenreg(l = list(m1, m2, m3),
          single.row = FALSE,
          stars = numeric(0),
          ci.force = TRUE,
          ci.test = NULL,
          custom.model.names = c("Modelo 1", "Modelo 2", "Modelo 3"),
          custom.coef.names = c("Intercepto", "Duración (min)",
                                "Largo título (caracteres)",
                                "Suscriptores (decenas de miles)"),
          digits = 2)
# ci.force = TRUE  -> muestra IC al 95% en vez de errores estándar
# ci.test = NULL   -> quita el * que marca si el 0 está fuera del IC
#                     (eso ya es un test de hipótesis; lo veremos más adelante)


# 7. Gráfico de intervalos de confianza ----------------------------------------

# 7.1 Con R base -------------------------------
ic <- confint(m3)[-1, ]   # IC 95% sin el intercepto
b  <- coef(m3)[-1]        # Coeficientes sin el intercepto
y  <- length(b):1         # Posición en el eje Y (el primero queda arriba)

par(mar = c(5, 12, 3, 2))   # Margen izquierdo amplio para los nombres
plot(b, y,
     xlim = range(ic), pch = 19, yaxt = "n",
     xlab = "Coeficiente (miles de visitas)", ylab = "",
     main = "Coeficientes e IC al 95% (Modelo 3)")
segments(ic[, 1], y, ic[, 2], y)       # Una línea por intervalo
abline(v = 0, lty = 2, col = "red")    # Línea de referencia en 0
axis(2, at = y, las = 1,
     labels = c("Duración (min)", "Largo título", "Suscriptores (10 mil)"))
par(mar = c(5, 4, 4, 2))    # Volvemos a los márgenes originales

# 7.2 Con coefplot (visto en clase 15) -------------------------------------------
coefplot(m3, intercept = FALSE)


# Apéndice: errores estándar ---------------------------------------------------

# A.1 Error estándar de la regresión (sigma) ----------------------------------
# "Residual standard error" en summary(): cuánto se equivoca el modelo,
# en promedio, en las unidades de Y (miles de visitas).
ssr <- sum(residuals(m3)^2)     # suma de residuos al cuadrado

sqrt(ssr / (n - k - 1))         # sigma a mano
sigma(m3)                       # sigma directo del modelo

# A.2 Error estándar de un coeficiente (a mano) --------------------------------
# Fórmula (clase 14): se(b_j) = sigma / raiz( SST_j * (1 - R²_j) )
# Lo hacemos para "duracion"

sigma_m3 <- sigma(m3)                                          # sigma
sst_dur  <- sum((videos$duracion - mean(videos$duracion))^2)   # SST de X
r2_dur   <- summary(lm(duracion ~ largo_titulo + suscriptores,
                       data = videos))$r.squared               # R²_j

sigma_m3 / sqrt(sst_dur * (1 - r2_dur))   # Error estándar a mano
summary(m3)$coefficients["duracion", "Std. Error"]   # Comparamos con lm()

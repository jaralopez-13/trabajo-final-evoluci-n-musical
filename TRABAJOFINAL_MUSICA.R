# TRABAJO FINAL DATA SCIENCE 
#EVOLUCIÓN MUSICAL 
#Jara López.
if(!require(tidyverse)) install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)
#cargo el archivo de kaggle de la música

mis_datos <- read.csv("dataset.csv")

# Fijamos semilla para que la muestra aleatoria no cambie al ejecutarlo
set.seed(123)

# FILTRAR Y  MUESTRA DE LAS CANCIONES 
# los 80-90 filtro por géneros clásicos muy populares 
canciones_antiguas <- mis_datos %>% 
  filter(track_genre %in% c("rock", "synth-pop", "hard-rock", "disco")) %>% 
  filter(popularity > 50) %>% 
  sample_n(50) %>%   
  mutate(epoca = "Años 80-90")

# Para la actualidad, éxitos globales de hoy
canciones_actuales <- mis_datos %>% 
  filter(track_genre %in% c("pop", "dance", "edm", "hip-hop", "latino")) %>% 
  filter(popularity > 75) %>% 
  sample_n(50) %>%   
  mutate(epoca = "Actualidad")

# Juntamos ambas épocas 
dataset_final <- rbind(canciones_antiguas, canciones_actuales)

#Convertimos la duración de milisegundos a minutos reales
dataset_final$duration_min <- (dataset_final$duration_ms / 1000) / 60
canciones_actuales$duration_min <- (canciones_actuales$duration_ms / 1000) / 60

#HISTOGRAMAS

# Histograma del Tempo (BPM) general de tu muestra
hist(dataset_final$tempo, 
     main = "Distribución General del Tempo (BPM)", 
     xlab = "BPM (Ritmo)", 
     col = "#1DB954", 
     border = "white")

# Histograma de la Energía general de tu muestra
hist(dataset_final$energy, 
     main = "Distribución General de la Energía", 
     xlab = "Nivel de Energía (0 a 1)", 
     col = "#535353", 
     border = "white")



# COMPARACIÓN (Boxplots / Gráficos de cajas)

# Pasamos la duración de milisegundos a minutos 
dataset_final$duration_min <- (dataset_final$duration_ms / 1000) / 60

# Boxplot 1: Comparación de Duración por Época 
boxplot(duration_min ~ epoca, data = dataset_final,
        main = "Comparación de la Duración por Época",
        ylab = "Duración en minutos", 
        col = c("#1DB954", "#191414"))

# Boxplot 2: Comparación de Energía por Época 
boxplot(energy ~ epoca, data = dataset_final,
        main = "Comparación del Nivel de Energía por Época",
        ylab = "Nivel de Energía (0 a 1)", 
        col = c("#1DB954", "#4A90E2"))

#ANÁLISIS DE HIPÓTESIS, PRUEBAS T DE STUDENT

# Contraste de hipótesis sobre la DURACIÓN media de las canciones

# H0: La duración media de los 80-90 es igual a la de la actualidad.
# H1: La duración media de los 80-90 es significativamente diferente.
test_duracion <- t.test(duration_min ~ epoca, data = dataset_final)
print("--- PRUEBA T PARA LA DURACIÓN DE LAS CANCIONES ---")
print(test_duracion)

# Prueba 2: Contraste de hipótesis sobre la ENERGÍA media de las canciones
# H0: La energía media de los 80-90 es igual a la de la actualidad.
# H1: La energía media de los 80-90 es significativamente diferente.
test_energia <- t.test(energy ~ epoca, data = dataset_final)
print("--- PRUEBA T PARA LA ENERGÍA DE LAS CANCIONES ---")
print(test_energia)

# PREDICCIONES (Correlación y Regresión Lineal)

# Matriz de correlación para ver cómo se relacionan las variables entre sí
variables_numericas <- dataset_final[, c("tempo", "energy", "valence", "popularity")]
print("--- MATRIZ DE CORRELACIÓN ---")
print(cor(variables_numericas))

# Modelo de Regresión Lineal para ver qué hace exitosa a una canción hoy en día
canciones_actuales$duration_min <- (canciones_actuales$duration_ms / 1000) / 60
modelo_regresion <- lm(popularity ~ tempo + energy + valence + duration_min, data = canciones_actuales)
print("--- RESULTADOS DE LA REGRESIÓN LINEAL (lm) ---")
print(summary(modelo_regresion))
# MAPA DE PUNTOS (Gráfico de Dispersión)
# Cruzamos la Energía con la Popularidad en las canciones actuales
plot(canciones_actuales$energy, canciones_actuales$popularity,
     main = "Relación entre Energía y Popularidad (Hoy)",
     xlab = "Nivel de Energía (0 a 1)",
     ylab = "Popularidad en Spotify",
     pch = 19,        
     col = "#1DB954") 

# línea roja de tendencia para ver la dirección de los puntos
abline(lm(popularity ~ energy, data = canciones_actuales), col = "red", lwd = 2)
View(dataset_final)



## TRABAJO FINAL DATA SCIENCE.
## Análisis de la evolución musical entre éxitos de distintas épocas.
Este repositorio contiene la investigación cuantitativa para el análisis comparativo entre éxitos de la música entre los años 80-90 y la actualidad.
 ## Autora: Jara López Pérez
   ## Asignatura: Data Science/ Profesor: Modesto Escobar
Instrucciones de reproducción del análisis
1. Clona o descarga este repositorio.
2. Asegúrate de que los archivos `TRABAJOFINAL_MUSICA.R` y `dataset.csv` están en la **misma carpeta**.
3. Abre `TRABAJOFINAL_MUSICA.R` en RStudio.
4. Ejecuta todo el script seleccionando"Run".
5. Los resultados se mostrarán en la consola y en el panel de plots.
   
## Estructura del repositorio
- `TRABAJOFINAL_MUSICA.R` → script completo con análisis.
- `dataset.csv` → datos originales (Spotify, vía Kaggle).
- `README.md` → este archivo.
- 
## Metodología resumida

- Muestra aleatoria de 100 canciones (50 por época) con semilla fija (`set.seed(123)`).
- Géneros 80-90: rock, synth-pop, hard-rock, disco (popularidad > 50).
- Géneros actuales: pop, dance, edm, hip-hop, latino (popularidad > 75).
- Pruebas t de Student para duración y energía.
- Regresión lineal múltiple para predecir popularidad.


library("here")
library("ggplot2")

library(ggplot2)
library(here)

crear_histograma <- function(tabla) {
  # tabla debe tener columnas: Marca_de_Clase y Frecuencia_Absoluta
  
  histograma <- ggplot(tabla, aes(x = factor(Marca_de_Clase), y = Frecuencia_Absoluta)) +
    geom_col(
      fill = "lightblue", 
      color = "black"
    ) +
    labs(
      title = "Histograma de Frecuencias",
      x = "Clases",
      y = "Frecuencia Absoluta"
    ) +
    theme_minimal()
  
  # Ruta de guardado (asegúrate que la carpeta exista)
  save_path <- here("resultados", "histograma.jpg")
  
  # Guardar gráfico
  ggsave(
    filename = save_path, 
    plot = histograma, 
    width = 10, 
    height = 6, 
    units = "in", 
    dpi = 300
  )
  
  return(histograma)
}



# función para crear un gráfico de ojiva

crear_ojiva <- function(tabla_frecuencias, titulo = "Gráfico de Ojiva (Frecuencias Acumuladas)") {
    Li_inicial <- tabla_frecuencias$Limite_Inferior[1]
    N_total <- max(tabla_frecuencias$Frecuencia_Acumulada)
    
    punto_inicio <- data.frame(
        Limite_Superior = Li_inicial,
        Frecuencia_Acumulada = 0
    )
    
    datos_ojiva <- data.frame(
        Limite_Superior = tabla_frecuencias$Limite_Superior,
        Frecuencia_Acumulada = tabla_frecuencias$Frecuencia_Acumulada
    )
    
    datos_completos_ojiva <- rbind(punto_inicio, datos_ojiva)
    
    # Crea el gráfico de Ojiva
    grafico <- ggplot(datos_completos_ojiva, aes(x = Limite_Superior, y = Frecuencia_Acumulada)) +
        # Dibuja la línea que conecta los puntos
        geom_line(color = "blue", size = 1) +
        # Añade puntos a cada límite superior (incluyendo el punto inicial en Li)
        geom_point(color = "red", size = 2) + 
        # Añade etiquetas y título
        labs(
            title = titulo,
            x = "Límites Superiores de Clase",
            y = "Frecuencia Acumulada (Fa)"
        ) +
        scale_y_continuous(limits = c(0, N_total), breaks = seq(0, N_total, by = max(1, round(N_total/5)))) +
        theme_minimal()
    
      save_path <- here("resultados", "ojiva.jpg")

  ggsave(
    filename = save_path, 
    plot = grafico, 
    width = 10, 
    height = 6, 
    units = "in", 
    dpi = 300
  )
    print(grafico)
}


crear_poligono_suavizado <- function(tabla_frecuencias, nombre_archivo, sesgo_texto, tipo_distribucion) {
  
  titulo_grafico <- "Polígono de Frecuencias (Suavizado)"
  ruta_guardado <- "resultados/poligono_suavizado.jpg"
  
  # Prepara el dataframe usando las columnas específicas de la tabla
  datos_poligono <- data.frame(
    Marca = tabla_frecuencias$Marca_de_Clase,
    Frecuencia = tabla_frecuencias$Frecuencia_Absoluta
  )
  
  # Subtítulo con datos obtenidos de los parametros de la funcion
  subtitulo <- paste("Datos:", nombre_archivo, "|", sesgo_texto, "|", tipo_distribucion)
  
  # Crea la curva suavizada
  poligono_suavizado <- ggplot(datos_poligono, aes(x = Marca, y = Frecuencia)) +
    geom_smooth(
      method = "loess",
      span = 0.6,
      se = FALSE,
      color = "#E41A1C",
      linewidth = 1.5
    ) +
    labs(
      title = titulo_grafico,
      subtitle = subtitulo,
      x = "Marca de clase",
      y = "Frecuencia"
    ) +
    theme_minimal() +
    theme(
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(face = "italic", size = 11, margin = margin(b = 10))
    )
  
  # Guardar imagen
  ggsave(
    filename = ruta_guardado, 
    plot = poligono_suavizado, 
    width = 10, 
    height = 6, 
    units = "in", 
    dpi = 300
  )
  
  return(poligono_suavizado)
}

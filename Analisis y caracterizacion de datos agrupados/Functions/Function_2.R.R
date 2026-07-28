library("here")
library("ggplot2")

# Función para crear la tabla de frecuencias
crear_tabla <- function (nombre_archivo) {
  
  # Paso 1: Leer y ordenar datos
  datos <- scan(file=here("Data", nombre_archivo ), what=numeric(), sep = ",")
  datos.ordenados <- sort(datos)
  N=length(datos)
  
  # Paso 2: Calcular número de datos y clases
  
  K <- floor(1 + log2(N))
  
  # Paso 3: Calcular rango y amplitud
  rango <- max(datos.ordenados) - min(datos.ordenados)
  amplitud <- ceiling(rango / K)
  
  # Paso 4: Crear límites y marcas de clase
  lims.inf <- seq(min(datos.ordenados) - 1, max(datos.ordenados) + amplitud, by = amplitud)
  lims.inf <- lims.inf-.05
  lims.sup <- lims.inf[-1]
  lims.sup <- lims.sup+1
  lims.inf <- lims.inf+1
  
  lims.inf <- lims.inf[-length(lims.inf)]
  marca.de.clase <- (lims.inf + lims.sup) / 2
  
  # Paso 5: Frecuencia absoluta
  f.abs <- numeric(length(lims.inf))
  for (i in seq_along(lims.inf)) {
    f.abs[i] <- sum(datos >= lims.inf[i] & datos < lims.sup[i])
  }
  
  # Paso 6: Frecuencia relativa
  f.rel <- f.abs / N
  
  # Paso 7: Frecuencia acumulada
  f.ac <- cumsum(f.abs)
  
  #paso 8 fi x Xi
  fixi<- f.abs*marca.de.clase
  
  # Paso 9: Crear tabla de frecuencias
  tabla.frecuencias <- data.frame(
    Limite_Inferior = lims.inf,
    Limite_Superior = lims.sup,
    Marca_de_Clase = marca.de.clase,
    Frecuencia_Absoluta = f.abs,
    Frecuencia_Relativa = round(f.rel, 4),
    Frecuencia_Acumulada = f.ac,
    FiXi= fixi
  )
  # También se devuelve los datos originales para el histograma
  return (list(tabla = tabla.frecuencias, datos = datos)) 
}
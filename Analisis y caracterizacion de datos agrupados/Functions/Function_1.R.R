# Función para calcular medidas de tendencia central y dispersión

calcular_medidas_tendencia_central <- function(tabla) {
  xi <- tabla$Marca_de_Clase
  fi <- tabla$Frecuencia_Absoluta
  N <- sum(fi)
  amplitud <- tabla$Limite_Superior[1] - tabla$Limite_Inferior[1]

  # ---- Media aritmética ----
  ma <- round(sum(tabla$FiXi) / N, 4)

  # ---- Mediana ----
  # match busca el índice de la primera clase cuya frecuencia acumulada >= KN
  KN <- N/2
  indice_mediana <- match(TRUE, tabla$Frecuencia_Acumulada >= KN)
  Li <- tabla$Limite_Inferior[indice_mediana]
  fi_mediana <- tabla$Frecuencia_Absoluta[indice_mediana]
  Fa_anterior <- ifelse(indice_mediana == 1, 0, tabla$Frecuencia_Acumulada[indice_mediana - 1])
  mediana <- round(Li + ((KN - Fa_anterior) / fi_mediana) * amplitud, 4)
  
  # ---- Cuartiles ----
  # Q1
  KQ1 <- N/4
  indice_Q1 <- match(TRUE, tabla$Frecuencia_Acumulada >= KQ1)
  Li_Q1 <- tabla$Limite_Inferior[indice_Q1]
  fi_Q1 <- tabla$Frecuencia_Absoluta[indice_Q1]
  Fa_anterior_Q1 <- ifelse(indice_Q1 == 1, 0, tabla$Frecuencia_Acumulada[indice_Q1 - 1])
  Q1 <- Li_Q1 + ((KQ1 - Fa_anterior_Q1) / fi_Q1) * amplitud
  
  # Q3
  KQ3 <- 3*N/4
  indice_Q3 <- match(TRUE, tabla$Frecuencia_Acumulada >= KQ3)
  Li_Q3 <- tabla$Limite_Inferior[indice_Q3]
  fi_Q3 <- tabla$Frecuencia_Absoluta[indice_Q3]
  Fa_anterior_Q3 <- ifelse(indice_Q3 == 1, 0, tabla$Frecuencia_Acumulada[indice_Q3 - 1])
  Q3 <- Li_Q3 + ((KQ3 - Fa_anterior_Q3) / fi_Q3) * amplitud
  
  RSI <- (Q3 - Q1)/2
  
  # ---- Percentiles ----
  # P10
  KP10 <- 0.10*N
  indice_P10 <- match(TRUE, tabla$Frecuencia_Acumulada >= KP10)
  Li_P10 <- tabla$Limite_Inferior[indice_P10]
  fi_P10 <- tabla$Frecuencia_Absoluta[indice_P10]
  Fa_anterior_P10 <- ifelse(indice_P10 == 1, 0, tabla$Frecuencia_Acumulada[indice_P10 - 1])
  P10 <- Li_P10 + ((KP10 - Fa_anterior_P10) / fi_P10) * amplitud
  
  # P90
  KP90 <- 0.90*N
  indice_P90 <- match(TRUE, tabla$Frecuencia_Acumulada >= KP90)
  Li_P90 <- tabla$Limite_Inferior[indice_P90]
  fi_P90 <- tabla$Frecuencia_Absoluta[indice_P90]
  Fa_anterior_P90 <- ifelse(indice_P90 == 1, 0, tabla$Frecuencia_Acumulada[indice_P90 - 1])
  P90 <- Li_P90 + ((KP90 - Fa_anterior_P90) / fi_P90) * amplitud
  
  RSP <- (P90 - P10)/2
  
  # ---- Desviación media ----
  DM <- sum(fi * abs(xi - ma)) / N
  
  # ---- Varianza y desviación estándar ----
  varianza <- sum(fi * (xi - ma)^2) / N
  desviacion_estandar <- sqrt(varianza)
  
  # ---- Z-score para la 3ª frecuencia ----
  x3 <- xi[3]
  z_score_3 <- (x3 - ma) / desviacion_estandar
  
  # ---- Coeficiente de dispersión (coeficiente de variación) ----
  v <- desviacion_estandar / ma
  
  # ---- Coeficiente de desviación intercuartílica ----
  coef_IQR <- (Q3 - Q1) / (Q3 + Q1)
  
  # ---- Devolver resultados ----
  return(data.frame(
    Media_Aritmetica = ma,
    Mediana = mediana,
    RSI = round(RSI, 4),
    RSP = round(RSP, 4),
    Desviacion_Media = round(DM, 4),
    Varianza = round(varianza, 4),
    Desviacion_Estandar = round(desviacion_estandar, 4),
    Zscore_3ra_Frecuencia = round(z_score_3, 4),
    Coef_Dispersion_v = round(v, 4),
    Coef_IQR = round(coef_IQR, 4)
  ))
}

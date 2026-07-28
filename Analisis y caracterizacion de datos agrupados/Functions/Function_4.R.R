momentos_medidas_de_distribucion <- function(tabla) {
  # Datos indispensables
  xi <- tabla$Marca_de_Clase
  fi <- tabla$Frecuencia_Absoluta
  FiXi <- tabla$FiXi
  N <- sum(fi)
  amplitud <- tabla$Limite_Superior[1] - tabla$Limite_Inferior[1]
  n_momentos <- 1:4   #son 4 momentos por cada tipo
  
  # Función para obtener percentiles (mediana, cuartiles,deciles,percentiles etc.)
  encontrar_parte <- function(K_pos) {
    indice <- match(TRUE, tabla$Frecuencia_Acumulada >= K_pos)
    if (is.na(indice)) return(NA)
    Li <- tabla$Limite_Inferior[indice]
    fi_clase <- tabla$Frecuencia_Absoluta[indice]
    Fa_anterior <- ifelse(indice == 1, 0, tabla$Frecuencia_Acumulada[indice - 1])
    return(Li + ((K_pos - Fa_anterior) / fi_clase) * amplitud)
  }
  
  # Media
  media_aritmetica <- sum(FiXi) / N
  
  # Varianza y desviación estándar
  mu_2 <- sum(fi * (xi - media_aritmetica)^2) / N
  desviacion_estandar <- sqrt(mu_2)
  
  # Mediana y cuartiles (usando la funcion que creamos arriba)
  mediana <- encontrar_parte(N / 2)
  Q1 <- encontrar_parte(N / 4)
  Q3 <- encontrar_parte(3 * N / 4)
  
  # Moda aproximada (pearson) esto suponiendo que la tabla solo tiene una moda
  moda_aprox <- 3 * mediana - 2 * media_aritmetica
  
  # Arrays de momentos
  mu_origen_arr <- numeric(4)
  mu_media_arr <- numeric(4)
  mu_mediana_arr <- numeric(4)
  mu_adimensional_arr <- numeric(4)
  
  for (k in n_momentos) {
    mu_origen_arr[k] <- sum(fi * xi^k) / N
    mu_media_arr[k] <- sum(fi * (xi - media_aritmetica)^k) / N
    mu_mediana_arr[k] <- sum(fi * (xi - mediana)^k) / N
    if (k > 1) {
      mu_adimensional_arr[k] <- mu_media_arr[k] / (desviacion_estandar^k)
    } else {
      mu_adimensional_arr[k] <- 0
    }
  }
  
  # Sesgos y curtosis
  Sk_p1 <- 3 * (media_aritmetica - mediana) / desviacion_estandar
  Sk_p2 <- (media_aritmetica - moda_aprox) / desviacion_estandar
  Sk_Q <- (Q3 + Q1 - 2 * mediana) / (Q3 - Q1)
  Curtosis <- mu_media_arr[4] / (mu_2^2)
  Exceso_Curtosis <- Curtosis - 3
  
  #usamos if para definir que tipo de distribucion tenemos segun el exeso de curtosis
  tipo <- ifelse(Exceso_Curtosis > 0, "Leptocúrtica",
                 ifelse(Exceso_Curtosis < 0, "Platicúrtica", "Mesocúrtica"))
  
  # Dataframe de salida
  df_momentos <- data.frame(
    Metrica = c(
      paste0("m", n_momentos, "_origen"),   #paste0 sirve para unir texto y bariables en uns mensaje
      paste0("m", n_momentos, "_media"),
      paste0("m", n_momentos, "_mediana"),
      paste0("m", n_momentos, "_adimensional")
    ),
    Valor = round(c(mu_origen_arr, mu_media_arr, mu_mediana_arr, mu_adimensional_arr), 4)
  )
  
  df_resumen <- data.frame(
    Metrica = c("Media", "Mediana", "Moda_aprox", "Desviacion_Estandar",
                "Sesgo_Pearson_1", "Sesgo_Pearson_2", "Sesgo_Cuartil",
                "Curtosis", "Exceso_Curtosis", "Tipo_Distribucion"),
    Valor = c(media_aritmetica, mediana, moda_aprox, desviacion_estandar,
              Sk_p1, Sk_p2, Sk_Q, Curtosis, Exceso_Curtosis, tipo)
  )
  
  df_final <- rbind(df_momentos, df_resumen)
  return(df_final)
}

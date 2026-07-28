# Función para calcular medidas de tendencia central y dispersión

calcular_medias <- function(tabla) {
  xi <- tabla$Marca_de_Clase
  fi <- tabla$Frecuencia_Absoluta
  N <- sum(fi)
  amplitud <- tabla$Limite_Superior[1] - tabla$Limite_Inferior[1]
  
  # Media Aritmética
  ma <- round(sum(tabla$FiXi) / N, 4)
  
  # Media Armónica
  sum_fi_sobre_xi <- sum(fi / xi)
  ma_armonica <- round(N / sum_fi_sobre_xi, 4)
  
  # Media Geométrica
  sum_fi_por_log_xi <- sum(fi * log(xi))
  log_ma_geometrica <- sum_fi_por_log_xi / N
  ma_geometrica <- round(exp(log_ma_geometrica), 4)
  
  # Media Cuadrática
  sum_fi_por_xi_cuadrado <- sum(fi * (xi^2))
  ma_cuadratica <- round(sqrt(sum_fi_por_xi_cuadrado / N), 4)
  
  # Mediana
  # La función match busca la posición del primer valor que cumple la condición.
  # En este caso, localiza la clase donde la frecuencia acumulada es mayor o igual a KN.
  # La función ifelse permite escribir un condicional en una sola línea.
  KN <- N/2
  indice_mediana <- match(TRUE, tabla$Frecuencia_Acumulada >= KN)
  Li <- tabla$Limite_Inferior[indice_mediana]
  fi_mediana <- tabla$Frecuencia_Absoluta[indice_mediana]
  Fa_anterior <- ifelse(indice_mediana == 1, 0, tabla$Frecuencia_Acumulada[indice_mediana - 1])
  mediana <- round(Li + ((KN - Fa_anterior) / fi_mediana) * amplitud, 4)
  
  # Devolver resultados
  return(data.frame(
    Media_Aritmetica = ma,
    Media_Armonica = ma_armonica,
    Media_Geometrica = ma_geometrica,
    Media_Cuadratica = ma_cuadratica,
    Mediana = mediana
  ))
}

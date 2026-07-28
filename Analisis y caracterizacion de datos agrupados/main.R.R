# main.R

rm(list=ls())
library("here")
library("ggplot2")

# Cargar las funciones individuales desde la carpeta 'funciones'
source("functions/tabla.R")
source("functions/medias.R")
source("functions/tendenciaCentral.R")
source("functions/momentos.R")
source("functions/graficas.R")



#nombre del archivo en /data
archivo_nombre <- 'datos_equipo_2.txt'

# Se llama a la función para crear la tabla en base a los datos
resultados_tabla <- crear_tabla(nombre_archivo=archivo_nombre)
tabla <- resultados_tabla$tabla
datos_originales <- resultados_tabla$datos

#_______________medidas de tendencia central_________________________________

medias <- calcular_medias(tabla)

#_______________medias de tendencia central_________________________________


medidas_centrales <- calcular_medidas_tendencia_central(tabla)
#_________________________momentos__________________________________________

# momentos centrales
momentos <- momentos_medidas_de_distribucion(tabla)

#_________________________graficos__________________________________________

#histograma
crear_histograma(tabla)

#llamar funcion de ojiba
graf_ojiba <- crear_ojiva(tabla)


#esta parte es para pasarle sesgo y el tipo de distribucion a la funcion del poligono y que lo ponga en el titulo
        # Extraer sesgo (ejemplo: Sesgo_Pearson_1)
        sesgo_valor <- momentos$Valor[momentos$Metrica == "Sesgo_Pearson_1"]

        # Convertir a texto interpretativo
        sesgo_texto <- ifelse(sesgo_valor > 0, "Sesgo: Positivo", 
                            ifelse(sesgo_valor < 0, "Sesgo: Negativo", "Sesgo: Nulo"))

        # Extraer tipo de distribución
        tipo_distribucion <- momentos$Valor[momentos$Metrica == "Tipo_Distribucion"]


#distribucion
distribucion <- crear_poligono_suavizado(tabla,archivo_nombre,sesgo_valor,tipo_distribucion)

#_________________________Imprimir Data Frames______________________________

print(tabla)
print(medias)
print(medidas_centrales)
print(momentos)

# Análisis y Caracterización de Datos Agrupados en R

Un entorno computacional modular desarrollado en **R** para el análisis descriptivo, caracterización estadística y representación gráfica de datos agrupados mediante tablas de distribución de frecuencias, medidas de tendencia central, momentos estadísticos y análisis de forma (sesgo y curtosis).

---

## Tabla de Contenidos
- [Descripción General](#descripción-general)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Características y Funcionalidades](#características-y-funcionalidades)
- [Requisitos e Instalación](#requisitos-e-instalación)
- [Uso e Instrucciones](#uso-e-instrucciones)
- [Metodología Estadística](#metodología-estadística)
- [Autores](#autores)

---

## Descripción General

Este proyecto implementa la Regla de Sturges y diversas técnicas estadísticas avanzadas para procesar conjuntos de datos en **R**. Permite automatizar el flujo completo de análisis descriptivo para datos agrupados:

1. **Agrupamiento y Distribución:** Generación de tablas de frecuencia completas (frecuencias absolutas, relativas, acumuladas y marcas de clase).
2. **Tendencia Central y Dispersión:** Cálculo de medias (aritmética, armónica, geométrica, cuadrática), mediana, moda aproximada, varianza, desviación estándar, rango semi-intercuartil (RSI) y coeficientes de variación.
3. **Momentos Estadísticos:** Cálculo de momentos con respecto al origen, a la media, a la mediana y momentos adimensionales.
4. **Análisis de Forma:** Evaluación del sesgo (Pearson, Bowley/Cuartílico, Kelly/Percentílico) y curtosis (Fisher, Exceso de curtosis y coeficiente percentílico/Moors).
5. **Visualización Gráfica:** Generación automática de Histogramas de Frecuencia, Gráficas de Ojiva y Polígonos de Frecuencia Suavizados utilizando `ggplot2`.

---

## Estructura del Proyecto

De acuerdo con la organización modular del repositorio:

```text
Analisis y caracterizacion de datos agrupados/
│
├── Data/                          # Archivos de entrada (.txt, .csv) con datos brutos
├── Functions/                     # Scripts modulares en R con las funciones de cálculo
│   ├── crear_tabla.R              # Generación de tablas de frecuencias (Regla de Sturges)
│   ├── calcular_medias.R          # Cálculo de medidas de tendencia central y dispersión
│   └── momentos.R                 # Cálculo de momentos, sesgo, curtosis y clasificación
├── Reporte/                       # Documentación del proyecto, reportes y PDF formal
|   |_ EA_Reporte_Proyecto_02.pdf
├── Resultados/                    # Exportación automática de tablas y gráficas generadas
├── main.R                         # Script principal ejecutor del flujo de trabajo
└── R.Rproj                        # Archivo de proyecto de RStudio
```

---

## Características y Funcionalidades

- **Carga Dinámica:** Lectura de datos mediante rutas independientes del sistema operativo con el paquete `here`.
- **Análisis Automatizado:** Cálculo inmediato de más de 25 métricas estadísticas a partir de archivos de datos numéricos.
- **Visualización de Alta Calidad:** Generación de histogramas, ojivas y polígonos suavizados dinámicos con superposición de medias y métricas clave.
- **Estructura Modular:** Limpieza de código y facilidad de mantenimiento separando la lógica en la carpeta `Functions/`.

---

## Requisitos e Instalación

### Prerrequisitos
Tener instalado **R** (versión ≥ 4.0.0) y preferentemente **RStudio**.

### Librerías Requeridas
El proyecto utiliza las siguientes paqueterías de R:

```R
install.packages("here")
install.packages("ggplot2")
```

---

## Uso e Instrucciones

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/Analisis-y-caracterizacion-de-datos-agrupados.git
   ```
2. **Colocar los datos:**
   Agrega tu archivo de datos (valores separados por coma o salto de línea) dentro de la carpeta `Data/`.
3. **Ejecutar el proyecto:**
   Abre el archivo `R.Rproj` en RStudio o ejecuta directamente el script principal:
   ```R
   source("main.R")
   ```
4. **Consultar Resultados:**
   Las tablas calculadas y los gráficos generados se guardarán o desplegarán en la carpeta `Resultados/`.

---

## Metodología Estadística

- **Número de Clases ($K$):** Regla de Sturges: $K = 1 + \log_2(N)$
- **Marca de Clase ($x_i$):** $x_i = rac{L_{inf} + L_{sup}}{2}$
- **Media Aritmética ($\mu$):** $\mu = rac{\sum f_i x_i}{N}$
- **Momentos Centrales ($\mu_k$):** $\mu_k = rac{\sum f_i (x_i - \mu)^k}{N}$
- **Exceso de Curtosis ($\gamma_2$):** $\gamma_2 = rac{\mu_4}{\sigma^4} - 3$
  - $\gamma_2 > 0$: **Leptocúrtica**
  - $\gamma_2 = 0$: **Mesocúrtica**
  - $\gamma_2 < 0$: **Platicúrtica**

---


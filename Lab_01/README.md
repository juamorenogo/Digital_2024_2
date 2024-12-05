# LAB 01 Digital 2024 - 02

En este laboratorio se realiza la caracterización de 2 _IC's_ negadores, cuya diferencia se encuentra en la tecnología en la que basan su funcionamiento. En cada carpeta se encuentra una explicación detallada del proceso y los diferentes archivos fuentes usados para todo el procedimiento.

* [Proceso SN70LS04](SN70LS04)
* [Proceso CD4069](CD4069)
* [Marco Teórico]()

Por lo anterior , en este archivo se realiza la compilación de los resultados encontrados y a su vez la respectiva comparación entre ambas tecnologías.

---

# Resultados Y Comparación

---
## A tener en cuenta

(JAIME)
- [ ] CMOS PARTE 2 FAN OUT CON DATOS EXPERIMENTALES CD4069
- [x] Marco teorico en cada parte
- [ ] Obtener la característica de Vin vs Vout.
- [ ]  CMOS PARTE 2 FAN OUT CON DATOS EXPERIMENTALES TTL 

(SEBASTIAN)
- [ ] Simular cada compuerta con su modelo spice variando la frecuencia de la señal de entrada.
- [x] Simular los osciladores en anillo.
- [ ] Comparar las mediciones.
- [ ] Corregir TTL parte1
- [ ] Comparar los resultados de los tiempo medidos en el laboratorio con los obtenidos en la simulación.

---
## Osciladores 

Se compararon los valores obtenidos experimentalmente para los osciladores. De manera experimental, se encontró una mayor frecuencia en ambos casos, siendo específicamente **2 MHz** y **4 MHz**, mientras que el modelo teórico mostró el comportamiento esperado según el número de compuertas, sin embargo, los valores obtenidos de **773 kHz** y **1.7 MHz** evidencian la incompletitud del modelo teórico, lo que sugiere que el modelo no captura completamente todas las variables que afectan la frecuencia de oscilación. Además, estos resultados experimentales reflejan las limitaciones de los instrumentos de medición utilizados, que podrían no haber sido lo suficientemente precisos para detectar frecuencias más altas o haber introducido ciertos márgenes de error. El modelo teórico, al estar basado en un enfoque ideal, no consideró aspectos prácticos como la capacitancia parasitaria, la resistencia de las conexiones, o las características no ideales de las compuertas CMOS, factores que influyen en el comportamiento real del oscilador. Estos factores pueden haber causado una desviación respecto a los valores teóricos, lo que resalta la diferencia entre los resultados teóricos y los experimentales.

## Valores Lógicos

### TTL

### CMOS

## Tiempos 

### TTL

### CMOS

## Fan - In / Fan - Out

### TTL

### CMOS

## Característica Vin - Vout

## Barrido de frecuencias con compuerta IC
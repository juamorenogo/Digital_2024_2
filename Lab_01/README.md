# LAB 01 Digital 2024 - 02

En este laboratorio se realiza la caracterización de 2 _IC's_ negadores, cuya diferencia se encuentra en la tecnología en la que basan su funcionamiento. En cada carpeta se encuentra una explicación detallada del proceso y los diferentes archivos fuentes usados para todo el procedimiento.

* [Proceso SN70LS04](SN70LS04)
* [Proceso CD4069](CD4069)
* [Marco Teórico](1_Marco_Teórico)

Por lo anterior , en este archivo se realiza la compilación de los resultados encontrados y a su vez la respectiva comparación entre ambas tecnologías.

---

# Resultados Y Comparación

---
## A tener en cuenta

- [ ] CMOS PARTE 2 FAN OUT CON DATOS EXPERIMENTALES CD4069
- [x] Marco teorico en cada parte
- [ ] Obtener la característica de Vin vs Vout.
- [ ] CMOS PARTE 2 FAN OUT CON DATOS EXPERIMENTALES TTL 
- [ ] Simular cada compuerta con su modelo spice variando la frecuencia de la señal de entrada.
- [x] Simular los osciladores en anillo.
- [ ] Comparar las mediciones.
- [x] Corregir TTL parte1
- [ ] Comparar los resultados de los tiempo medidos en el laboratorio con los obtenidos en la simulación.

---
## Osciladores 

Se compararon los valores obtenidos experimentalmente para los osciladores. De manera experimental, se encontró una mayor frecuencia en ambos casos, siendo específicamente **2 MHz** y **4 MHz**, mientras que el modelo teórico mostró el comportamiento esperado según el número de compuertas, sin embargo, los valores obtenidos de **773 kHz** y **1.7 MHz** evidencian la incompletitud del modelo teórico, lo que sugiere que el modelo no captura completamente todas las variables que afectan la frecuencia de oscilación. Además, estos resultados experimentales reflejan las limitaciones de los instrumentos de medición utilizados, que podrían no haber sido lo suficientemente precisos para detectar frecuencias más altas o haber introducido ciertos márgenes de error. El modelo teórico, al estar basado en un enfoque ideal, no consideró aspectos prácticos como la capacitancia parasitaria, la resistencia de las conexiones, o las características no ideales de las compuertas CMOS, factores que influyen en el comportamiento real del oscilador. Estos factores pueden haber causado una desviación respecto a los valores teóricos, lo que resalta la diferencia entre los resultados teóricos y los experimentales.

---
## Valores Lógicos

### TTL

#### (VOH) - Lógico "1":
- **VOH (para VDD = 5V)**: El rango teórico para un **"1" lógico** debe estar entre **3 V** y **5 V**.
- **Valor experimental**: Los valores de **3 V a 5 V** obtenidos experimentalmente concuerdan con los valores esperados, por lo que, se puede asegurar que la calidad del circuito junto a las incertidumbres no afectaron de sobre manera los datos obtenidos

#### (VOL) - Lógico "0":
- **VOL (para VDD = 5V)**: El rango teórico para un **"0" lógico** debe estar entre **0 V** y **2 V**.
- **Valor experimental**: Los valores de **0 V a 2 V** nuevamente se encuentra dentro del rango esperado.

### CMOS

#### (VOH) - Lógico "1":
- **VOH (para VDD = 5V)**: El rango teórico para un **"1" lógico** debe estar entre **4.95 V** y **5 V**.
- **Valor experimental**: Los valores de **3.9 V a 5 V** obtenidos experimentalmente, no caen dentro de este rango, teniendo en cuenta que el fabricante da como mínimo teórico de **4.95 V**. Esto podría deberse a tolerancias o efectos no ideales en el circuito o mal interpretación del modelo o del procedimiento.

#### (VOL) - Lógico "0":
- **VOL (para VDD = 5V)**: El rango teórico para un **"0" lógico** debe estar entre **0 V** y **0.05 V**.
- **Valor experimental**: Los valores de **0 V a 1.5 V** están significativamente por encima del máximo teórico de **0.05 V**, lo que indica que la salida no está alcanzando un **"0" lógico** adecuado.


Aunque en el **TTL** se comprueba los datos especificados por el fabricante, en el **CMOS** no ocurre esto, sin embargo, si cumple con la cualidad esperada de tener rangos de operación lógica mas pequeños, por lo mismo, se teoriza que el _Datasheet_ utilizado no es el apropiado para este __IC__.

---
## Tiempos 

### TTL

#### Tiempos Teóricos (Datasheet)

- \( t_{pLH} \):
  - Para **VDD = 5V**: 9 ns (mínimo)

- \( t_{pHL} \):
  - Para **VDD = 5V**: 10 ns (mínimo)
#### Tiempos Prácticos (Mediciones)
- **Tiempo de Subida (Rise Time)**:
  - **tr80**: 26.3  ns
  - **tr**: 33.2 ns 

- **Tiempo de Bajada (Fall Time)**:
  - **tf80**: 19.6 ns
  - **tf**: 29.4 ns

- **Tiempo de Transición (high to low)** \( t_{THL} \): 16.8 ns
  
- **Tiempo de Transición (low to high)** \( t_{TLH} \):  100 ns
#### Comparación
- **Tiempo de Subida**: El _datasheet_ no proporciona datos de transición, no obstante, los datos obtenidos concuerdan con la teoría del sistema **TTL**.
  
- **Tiempo de Bajada**: El _datasheet_ no proporciona datos de transición, no obstante, los datos obtenidos concuerdan con la teoría del sistema **TTL**.

* **Tiempos de transición**:  Los tiempos de transición teóricos y prácticos presentan una gran disonancia, en especial el *low to high*, una posible razón para esto es el posible _no acoplamiento_ de impedancias, lo que puede producir efectos capacitivos parasíticos generando estas mediciones erróneas.

- **Desfase Propagacional**: El **tiempo de propagación** teórico es de **1 ns**. Los tiempos prácticos de subida y bajada  mayores sugieren que el retraso en el circuito está influenciado por características como la **capacitancia** o la **carga de los componentes**.


### CMOS

#### Tiempos Teóricos (Datasheet)
- \( t_{TLH} \):
  - Para **VDD = 5V**: 70 ns (mínimo)
  
- \( t_{THL} \):
  - Para **VDD = 5V**: 70 ns (mínimo)

- \( t_{pLH} \):
  - Para **VDD = 5V**: 55 ns (mínimo)

- \( t_{pHL} \):
  - Para **VDD = 5V**: 55 ns (mínimo)
#### Tiempos Prácticos (Mediciones)
- **Tiempo de Subida (Rise Time)**:
  - **tr80**: 74.35 ns
  - **tr**: 114.4 ns 

- **Tiempo de Bajada (Fall Time)**:
  - **tf80**: 81.3 ns
  - **tf**: 120 ns

- **Tiempo de Transición (high to low)** \( t_{THL} \): 8 ns
  
- **Tiempo de Transición (low to high)** \( t_{TLH} \):  60 ns
#### Comparación
- **Tiempo de Subida**: El tiempo de subida práctico \( tr \) de **114.4 ns** es más alto que el valor teórico de **70 ns**, lo que puede indicar efectos de carga, capacitancia o ineficiencia en el circuito.
  
- **Tiempo de Bajada**: El tiempo de bajada práctico \( tf \) de **120 ns** también es más alto que el valor teórico de **70 ns**, lo que podría estar relacionado con similares factores de carga o de configuración del circuito.

* **Tiempos de transición**:  Los tiempos de transición teóricos y prácticos presentan una gran disonancia, en especial el *low to high*, una posible razón para esto es el posible _no acoplamiento_ de impedancias, lo que puede producir efectos capacitivos parasíticos generando estas mediciones erróneas.

- **Desfase Propagacional**: El **tiempo de propagación** teórico es de **55 ns**. Los tiempos prácticos de subida y bajada ligeramente mayores sugieren que el retraso en el circuito está influenciado por características como la **capacitancia** o la **carga de los componentes**.

## Fan - In / Fan - Out

### TTL

### CMOS

## Característica Vin - Vout


## Barrido de frecuencias con compuerta IC

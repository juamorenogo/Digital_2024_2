# Comparación general

Hay varias características que definen a estos dos dispositivos y que resultan de mucha importancia para su aplicación. Se enlistan algunos de los más importantes:
+ La familia lógica indica la tecnología que emplea en la construcción de los transistores, que determinarán muchísimo las demás características como consumo de energía, consumo de corriente, fan-out, etc.
+ Cada chip contiene varios inversores dentro de sí, y ambos en particular tienen 6.
+ Los rangos de operación $V_{IH}$, $V_{IL}$, $V_{OH}$ y $V_{OL}$, los cuales determinarán las relaciones ALTO-BAJO entre las entradas y las salidas, además de la zona indeterminada de no uso.

| **Característica**          | **SN54LS04**                          | **TC4069UBP**                                     |
| --------------------------- | ------------------------------------- | ------------------------------------------------- |
| **Familia Lógica**          | TTL Low-Power Schottky (LS)           | CMOS                                              |
| **Número de Inversores**    | 6                                     | 6                                                 |
| **Voltaje de Alimentación** | 5V                                    | 3V a 15V                                          |
| **V<sub>IH</sub> Entrada**  | ≥ 2V                                  | ≥ 0.7 V<sub>DD</sub>                              |
| **V<sub>IL</sub> Entrada**  | ≤ 0.8V                                | ≤ 0.3 V<sub>DD</sub>                              |
| **V<sub>OH</sub> Salida**   | ≥ 3.4V                                | ≈ V<sub>DD</sub>                                  |
| **V<sub>OL</sub> Salida**   | ≤ 0.4V                                | ≈ GND                                             |
| **Tiempo de Propagación**   | ~8 ns                                 | 10-20 ns                                          |
| **Consumo de Energía**      | Alto                                  | Bajo                                              |
| **Fan-Out**                 | ~10                                   | 20+                                               |
| **Inmunidad al Ruido**      | Moderada                              | Alta                                              |
| **Corriente de Entrada**    | Requiere corriente                    | Muy baja (alta impedancia)                        |
| **Disipación de Potencia**  | Mayor                                 | Menor                                             |
| **Aplicaciones Típicas**    | Entornos industriales, alta velocidad | Dispositivos portátiles, sistemas de bajo consumo |

# Rangos de operación y Niveles de Voltaje

Los **rangos de operación** y los **niveles de voltaje**  son esenciales para garantizar la **fiabilidad**, **compatibilidad** y **eficiencia** de los sistemas electrónicos. Se da una explicación detallada de estos conceptos, enfocándonos en los niveles de voltaje característicos: **V<sub>IH</sub> (Voltaje de Entrada Alto)**, **V<sub>IL</sub> (Voltaje de Entrada Bajo)**, **V<sub>OH</sub> (Voltaje de Salida Alto)** y **V<sub>OL</sub> (Voltaje de Salida Bajo)**.

#### **1. Rangos de Operación**

El **rango de operación** de un dispositivo lógico define los límites de los parámetros eléctricos dentro de los cuales el dispositivo puede funcionar correctamente. Estos rangos incluyen el **voltaje de alimentación (V<sub>DD</sub>)**, la **frecuencia de operación**, y las **condiciones ambientales** como la temperatura. Para el TTL y el CMOS:

- **TTL (SN54LS04):**
  - **Voltaje de Alimentación (V<sub>DD</sub>):** Típicamente **5V**.
  - **Frecuencia de Operación:** Alta velocidad de conmutación, adecuada para aplicaciones que requieren respuestas rápidas.
  - **Consumo de Energía:** Relativamente alto debido a la naturaleza de la lógica TTL, que mantiene un consumo constante mientras está en operación.
  
- **CMOS (TC4069UBP):**
  - **Voltaje de Alimentación (V<sub>DD</sub>):** Amplio rango, generalmente entre **3V y 15V**, ofreciendo mayor flexibilidad para diferentes aplicaciones.
  - **Frecuencia de Operación:** Buena velocidad de conmutación, aunque puede variar dependiendo de la carga y el voltaje de alimentación.
  - **Consumo de Energía:** Muy bajo en estado estacionario, ya que solo consume energía durante las transiciones de los estados lógicos.

#### **2. Niveles de Voltaje de Entrada y Salida**

Determinan cómo las señales eléctricas son interpretadas por los dispositivos lógicos: si la señal representa BAJO o ALTO, y si subsecuentemente debería correspondientemente tener una salida ALTO o BAJO respectivamente (para el caso de los inversores). Específicamente, se definen umbrales que distinguen entre niveles lógicos **ALTOS** y **BAJOS**, tanto en las **entradas** como en las **salidas** de los dispositivos:

##### **a. Niveles de Voltaje de Entrada**

Los niveles de voltaje de entrada definen las condiciones bajo las cuales una señal de entrada es reconocida como un **nivel lógico alto (V<sub>IH</sub>, voltaje de entrada alto)** el cual es el voltaje mínimo requerido en la entrada para que el dispositivo lo reconozca como un **nivel lógico alto**, o un **nivel lógico bajo (V<sub>IL</sub>, voltaje de entrada bajo)** que es el voltaje máximo permitido en la entrada para que el dispositivo lo reconozca como un **nivel lógico bajo**.

- **TTL (SN54LS04):**
  - **V<sub>IH</sub>:** Mínimo **2V**. Esto significa que cualquier señal de entrada con un voltaje igual o superior a 2V será interpretada como un nivel lógico alto.
  - **V<sub>IL</sub>:** Máximo **0.8V**. Cualquier señal de entrada con un voltaje igual o inferior a 0.8V será interpretada como un nivel lógico bajo.
  
- **CMOS (TC4069UBP):**
  - **V<sub>IH</sub>:** Al menos **70% de V<sub>DD</sub>**. Por ejemplo, si V<sub>DD</sub> es 5V, entonces V<sub>IH</sub> debe ser ≥ 3.5V.
  - **V<sub>IL</sub>:** Máximo **30% de V<sub>DD</sub>**. Usando el mismo ejemplo de V<sub>DD</sub> = 5V, V<sub>IL</sub> debe ser ≤ 1.5V.
  
**Implicaciones:**
- **CMOS** ajusta sus umbrales de entrada en función del voltaje de alimentación, lo que le permite ser más flexible y compatible con diferentes niveles de señal.
- **TTL** tiene umbrales fijos, lo que puede limitar su adaptabilidad en sistemas con diferentes voltajes de operación.

##### **b. Niveles de Voltaje de Salida**

Los niveles de voltaje de salida determinan cómo las señales son generadas por el dispositivo lógico para representar niveles lógicos **ALTOS** y **BAJOS** bajo el mismo principio que con los niveles de entrada:

- **TTL (SN54LS04):**
  - **V<sub>OH</sub>:** Mínimo **3.4V**. Esto asegura que la señal de salida es suficientemente alta para ser interpretada como un nivel lógico alto.
  - **V<sub>OL</sub>:** Máximo **0.4V**. Garantiza que la señal de salida es lo suficientemente baja para ser interpretada como un nivel lógico bajo.
  
- **CMOS (TC4069UBP):**
  - **V<sub>OH</sub>:** Aproximadamente igual a **V<sub>DD</sub>**. Por ejemplo, si V<sub>DD</sub> es 5V, entonces V<sub>OH</sub> será cercano a 5V.
  - **V<sub>OL</sub>:** Aproximadamente igual a **GND** (0V). Esto asegura una clara distinción entre niveles lógicos altos y bajos.
  
**Implicaciones:**
- **CMOS** proporciona una mayor amplitud en los niveles de salida, lo que mejora el **margen de ruido** y reduce la probabilidad de errores de interpretación en sistemas con múltiples etapas de lógica.
- **TTL** tiene niveles de salida más limitados, lo que puede afectar la fiabilidad en entornos con altos niveles de ruido o con múltiples cargas conectadas.

#### **3. Importancia de los Umbrales de Voltaje**

Los umbrales de voltaje son cruciales para el correcto funcionamiento de los sistemas digitales por varias razones: la compatibilidad entre dispositivos, el margen de ruido, consumo de energía, la velocidad de conmutación.

Por un lado, la **compatibilidad entre dispositivos** asegura que los niveles de salida de un dispositivo coincidan con los niveles de entrada de los dispositivos siguientes, lo cual evita errores de interpretación y garantiza una comunicación efectiva.
  
El **margen de ruido**  entre los niveles de voltaje alto y bajo reduce la susceptibilidad a interferencias electromagnéticas y ruido en las líneas de señal, por lo que mejora la **inmunidad al ruido** del sistema.
  
La **velocidad de conmutación** se ven afectados por los niveles de voltaje. Dispositivos con umbrales más definidos y amplitudes de señal mayores pueden conmutar más rápidamente y con mayor fiabilidad.

Ahora bien, considerando los casos específicos de SN54LS04 (TTL) y TC4069UBP (CMOS):

- **SN54LS04 (TTL):**
  - **V<sub>IH</sub> y V<sub>IL</sub>:** Valores fijos de ≥ 2V y ≤ 0.8V, respectivamente, adaptados a un sistema de 5V.
  - **V<sub>OH</sub> y V<sub>OL</sub>:** Salidas limitadas a ≥ 3.4V y ≤ 0.4V, lo que puede ser insuficiente en sistemas que requieren mayores márgenes de señal.
  - **Rango de Alimentación:** Fijo a 5V, limitando su uso en aplicaciones que operan a diferentes voltajes.
  
- **TC4069UBP (CMOS):**
  - **V<sub>IH</sub> y V<sub>IL</sub>:** Proporcionales al V<sub>DD</sub>, permitiendo una adaptación dinámica según el voltaje de operación.
  - **V<sub>OH</sub> y V<sub>OL</sub>:** Salidas que se acercan al V<sub>DD</sub> y GND, proporcionando señales más robustas y claras.
  - **Rango de Alimentación:** Amplio (3V a 15V), aumentando su versatilidad para diversas aplicaciones, desde dispositivos portátiles hasta sistemas industriales.

# Tiempos de Subida, Bajada y Retardo en Dispositivos Lógicos: tr, tf, tphl, tplh

Estos parámetros afectan directamente el rendimiento, la velocidad y la fiabilidad de los sistemas electrónicos. Analizaremos detalladamente los **tiempos de subida (tr)**, **tiempo de bajada (tf)**, **tiempo de retardo de propagación alto a bajo (tphl)** y **tiempo de retardo de propagación bajo a alto (tplh)** para dos dispositivos lógicos específicos: el **SN54LS04 (TTL)** y el **TC4069UBP (CMOS)**.

#### **1. Definiciones**

El **tiempo de subida (tr)** es el tiempo que tarda una señal de salida en transicionar desde un **10%** de su valor máximo hasta un **90%** de dicho valor durante una transición de **bajo a alto**, mientras que el **tiempo de Bajada (tf)** es el tiempo que tarda una señal de salida en transicionar desde un **90%** de su valor máximo hasta un **10%** de dicho valor durante una transición de **alto a bajo**. Estos tiempos de transición determinan qué tan rápidamente una señal puede cambiar de un estado lógico a otro. Son cruciales para aplicaciones que requieren **alta velocidad** y **precisión temporal**, como en comunicaciones de alta frecuencia y procesamiento rápido de señales.

Hay dos **tiempos de retardo de propagación**, el **tphl** y el **tplh**. El **tphl (propagation delay high-to-low)** es el tiempo que transcurre desde que la señal de entrada cambia de **alto a bajo** hasta que la señal de salida alcanza el **50%** de su valor máximo en la transición de **alto a bajo**, mientras que el **tplh (propagation delay low-to-high)** es el tiempo que transcurre desde que la señal de entrada cambia de **bajo a alto** hasta que la señal de salida alcanza el **50%** de su valor máximo en la transición de **bajo a alto**. Como tal, el retardo de propagación es el tiempo que tarda una señal en propagarse a través del dispositivo lógico desde la entrada hasta la salida, y es un parámetro crítico para determinar la **velocidad máxima de operación** del circuito y para evitar **condiciones de carrera** que puedan causar errores lógicos.

#### **2. Características de Tiempo en SN54LS04 (TTL) y TC4069UBP (CMOS)**

A continuación, se presentan las especificaciones típicas en datasheets de **tr**, **tf**, **tphl** y **tplh** para ambos dispositivos:

| **Parámetro**            | **SN54LS04 (TTL Inverter)** | **TC4069UBP (CMOS Inverter)** |
|--------------------------|------------------------------|---------------------------------|
| **Tiempo de Subida (tr)**    | ~10 ns                       | ~20 ns                           |
| **Tiempo de Bajada (tf)**    | ~10 ns                       | ~20 ns                           |
| **Tiempo de Retardo tplh**   | ~8 ns                        | ~15 ns                           |
| **Tiempo de Retardo tphl**   | ~8 ns                        | ~15 ns                           |
Así pues, se esperan tiempos de transición rápidos adecuados para aplicaciones que demandan alta velocidad de conmutación y simétricos para el **SN54LS04 (TTL Inverter)**, mientras que se esperan tiempos más lento que el TTL, es suficientemente rápido para muchas aplicaciones estándar por parte del **TC4069UBP (CMOS Inverter)**, aunque los tiempos pueden aumentar si la carga capacitiva es alta.


---

---

---

Aquí tienes el **paso a paso detallado** para abordar y desarrollar el diseño del sistema propuesto siguiendo las etapas descritas, con un enfoque estructurado para facilitar el desarrollo del proyecto:

---

## **Paso a Paso**

### **1. Dominio Comportamental (Especificación y Algoritmo)**

#### **1.1 Diagrama de caja negra**

- Diseña un diagrama de caja negra donde se representen:
    - **Entradas:**
        - Estado de la red eléctrica (activo/inactivo).
        - Estado de la batería (cargada/descargada).
        - Presencia de radiación solar.
        - Paro de emergencia/mantenimiento.
    - **Salidas:**
        - Energización de la casa.
        - Indicador de batería descargada.
        - Indicador de red eléctrica disponible.
        - Indicador de radiación solar.

#### **1.2 Tabla de verdad**

- Desarrolla una **tabla de verdad** que relacione las entradas con las salidas deseadas:


| R | B | S | E | C | IBB | IRD | IS |
|---|---|---|---|---|-----|-----|----|
| 0 | 0 | 0 | 0 | 0 | 1   | 0   | 0  |
| 0 | 0 | 0 | 1 | 0 | 1   | 0   | 0  |
| 0 | 0 | 1 | 0 | 0 | 1   | 0   | 1  |
| 0 | 0 | 1 | 1 | 0 | 1   | 0   | 1  |
| 0 | 1 | 0 | 0 | 1 | 0   | 0   | 0  |
| 0 | 1 | 0 | 1 | 0 | 0   | 0   | 0  |
| 0 | 1 | 1 | 0 | 1 | 0   | 0   | 1  |
| 0 | 1 | 1 | 1 | 0 | 0   | 0   | 1  |
| 1 | 0 | 0 | 0 | 1 | 1   | 1   | 0  |
| 1 | 0 | 0 | 1 | 0 | 1   | 1   | 0  |
| 1 | 0 | 1 | 0 | 1 | 1   | 1   | 1  |
| 1 | 0 | 1 | 1 | 0 | 1   | 1   | 1  |
| 1 | 1 | 0 | 0 | 1 | 0   | 1   | 0  |
| 1 | 1 | 0 | 1 | 0 | 0   | 1   | 0  |
| 1 | 1 | 1 | 0 | 1 | 0   | 1   | 1  |
| 1 | 1 | 1 | 1 | 0 | 0   | 1   | 1  |

### **Leyenda:**

- **R**: Red eléctrica (1 = disponible, 0 = no disponible).
- **B**: Batería cargada (1 = cargada, 0 = descargada).
- **S**: Radiación solar (1 = presente, 0 = ausente).
- **E**: Paro de emergencia (1 = activado, 0 = no activado).
- **C**: Energizar casa (1 = energizada, 0 = no energizada).
- **IBB**: Indicador de batería baja (1 = baja, 0 = cargada).
- **IRD**: Indicador de red eléctrica disponible (1 = disponible, 0 = no disponible).
- **IS**: Indicador de radiación solar (1 = presente, 0 = ausente).

#### **1.3 Algoritmo (Diagrama de flujo)**

- Representa las decisiones lógicas del sistema en un **diagrama de flujo**, incluyendo:
    1. Verificar el estado de la red eléctrica.
    2. Si la red eléctrica está activa, conectar la casa a la red comercial.
    3. Si no hay red eléctrica, verificar si la batería está cargada.
    4. Si la batería está cargada, alimentar la casa desde el inversor.
    5. Si no hay red ni batería, desconectar la casa.
    6. Revisar estado de radiación solar para indicaciones visuales.
    7. Verificar paro de emergencia para desenergizar manualmente.

---

### **2. Dominio Físico Inicial (Circuito Eléctrico)**

#### **2.1 Circuito Eléctrico**

- Diseña el esquema eléctrico utilizando los componentes disponibles:
    - Relés para conmutar entre la red eléctrica y el inversor.
    - Sensores de estado de red, batería y radiación solar.
    - Botón de paro de emergencia para desconectar la casa.
- Asegúrate de reflejar la lógica on/off con contactos normalmente abiertos (NA) o cerrados (NC).

#### **2.2 Representación en lenguaje Ladder**

- Traduce el circuito eléctrico a un **diagrama ladder**, incluyendo:
    - Bobinas para relés.
    - Contactos para sensores y botones.
    - Indicadores como salidas activadas por las condiciones de los sensores.


![](../Pasted%20image%2020241212080608.png)



---

### **3. Simulación en Lenguaje Ladder**

- Usa un software de simulación de PLC (por ejemplo, **PLCSimulator**) para probar el funcionamiento del sistema.
    - Verifica que cada condición activa/desactiva los relés e indicadores correctamente.
    - Documenta las simulaciones y anota observaciones o ajustes necesarios.

![](../Pasted%20image%2020241212080656.png)

 En este caso de la tabla de verdad, no hay red eléctrica, la batería no está descargada y la casa está energizada. Como no hay red pero sí se cumplen las demás condiciones para indicar energía, entonces se prende el bombillo.
 
 Como no está descargada la batería, entonces no se prende su indicar, y tampoco se prende el indicador de red eléctrica. En este caso particular, no hay energía solar.
 ![](../Pasted%20image%2020241212080939.png)
---
Como otro caso particular, aquí sí hay red eléctrica disponible pero está activado el paro de emergencia (normalmente cerrado). La batería está descargada, y no afecta el indicador de energización, pero sí prende su indicador. También se indica que existe la red eléctrica y, como caso adicional, parecen estar cargándose las baterías de todas formas por la disponibilidad de radiación solar.

Se deja el paro de emergencia con el indicador de radiación solar por el ejercicio académico.
### **4. Dominio Estructural (Red de Compuertas Lógicas)**

#### **4.1 Red de compuertas lógicas**

- Convierte el diagrama ladder en una red lógica:
    - Usa AND, OR, NOT para representar la lógica combinacional.
    - Simplifica las expresiones con **mapas de Karnaugh**.
    - Representa el circuito con compuertas universales (NAND/NOR).

#### **4.2 Simulación Digital**

- Implementa la red en un software como **Digital**:
    - Verifica que las simulaciones cumplan con la tabla de verdad.
    - Exporta los diagramas y las tablas resultantes.

#### **4.3 LUT y Suma de Productos**

- Genera la tabla LUT (Look-Up Table) y la representación en formato de suma de productos.

---

### **5. Descripción en Lenguaje HDL (Hardware Description Language)**

#### **5.1 Traducción a Verilog**

- Desde el software Digital, exporta el diseño a Verilog y guarda el archivo como `top.v`.
- Documenta:
    - Los puertos del módulo.
    - Los operadores utilizados para representar las compuertas (AND, OR, NOT, etc.).
    - La relación con el diagrama de caja negra.

#### **5.2 Validación**

- Simula el archivo Verilog en un software como **ModelSim** o **Vivado** para verificar que cumpla con la especificación inicial.

---

### **6. Síntesis en FPGA (Dominio Físico Final)**

#### **6.1 Implementación en FPGA**

- Usa una FPGA (por ejemplo, Xilinx o Altera) para implementar el diseño:
    - Configura los pines y restricciones físicas (archivo `.xdc` o `.ucf`).
    - Conecta sensores y actuadores reales (pulsadores, LEDs, relés) para probar el sistema.

#### **6.2 Validación del sistema físico**

- Comprueba que el sistema responde correctamente a las condiciones reales:
    - Cambios en la red eléctrica.
    - Estado de carga de la batería.
    - Presencia o ausencia de radiación solar.
    - Activación manual del paro de emergencia.

---

### **7. Socialización del resultado**

#### **7.1 Repositorio Git**

- Crea un repositorio en GitHub, organizando los archivos en carpetas como:
    - `lab/diagrama_caja_negra`
    - `lab/circuito_ladder`
    - `lab/verilog`
    - `lab/fpga`
    - Incluye un archivo `README.md` con:
        - Descripción del proyecto.
        - Paso a paso del desarrollo.
        - Imágenes, diagramas, y enlaces.

#### **7.2 Vídeo**

- Crea un vídeo explicativo (máximo 5 minutos) mostrando:
    - El flujo de diseño.
    - Simulaciones en cada etapa.
    - Pruebas físicas en la FPGA.
    - Comparación con los objetivos iniciales.
- Comparte el enlace en el repositorio.

#### **7.3 Exposición**

- Prepara una presentación para compartir con tus compañeros:
    - Usa diapositivas claras con diagramas, simulaciones y resultados.
    - Resalta los retos encontrados y cómo los resolviste.

---

Este paso a paso asegura una transición clara entre cada etapa del diseño, validando el comportamiento esperado en cada dominio y garantizando que la solución cumpla con las especificaciones iniciales. ¡Buena suerte con tu proyecto!
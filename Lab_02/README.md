Índice:
owo

---
### Monitoreo del estado de carga de una batería.

Se requiere diseñar e implementar un sistema de monitoreo que supervise el nivel de carga de un banco de baterías compuesto por dos baterías. El nivel de carga total del banco está dado por la suma del nivel de carga de cada batería.

Estas baterías cuentan cada una con un sensor de tensión que entrega valores decimales entre 0 y 15 en sistema binario, dependiendo del nivel de carga de cada una, donde:

0 (`4'b0000`) ---> Batería completamente descargada.

15 (`4'b1111`) ---> Batería completamente cargada.
## Requisitos funcionales

**1. Detección de baterías descargadas:** Si una de las baterías tiene una carga de 0 (`4'b0000`), debe generarse una señal de advertencia para así poderla atender.

**2. Aviso de carga crítica:** Si la carga total del banco de baterías es igual o menor que el 10% de la carga máxima, se debe activar una señal de advertencia, ya sea visual, auditiva o ambas.

**3. Otros niveles de carga:** Se debe agregar al sistema otros indicadores para informar niveles de carga de interés, por ejemplo, nivel aceptable, regular y crítico.

**4. Implementación modular escalable:** El diseño completo debe constar de varios módulos para hacer el sistema escalable y claro, lo que facilitará también su validación y verificación. Cada grupo tendrá la libertad de decidir cómo organizar y conectar los módulos.
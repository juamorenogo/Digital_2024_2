# Definiciones

El término "fan-in" se refiere al número de entradas que una puerta lógica puede manejar correctamente. Por otra parte, el "fan-out" describe el número de entradas de otras puertas lógicas que una salida de una puerta lógica puede conducir sin degradar las señales.

## Impacto

Un mayor fan-in puede afectar el rendimiento de la puerta lógica, incluyendo tiempos de propagación y estabilidad de la señal. Un fan-out adecuado garantiza que las señales mantengan sus niveles lógicos esperados y que los tiempos de conmutación no se vean significativamente afectados

# Modelos TC4069UBP y SN70LS04

Para el modeLo TC4069UBP se tiene una baja disipación en estado estático debido a la tecnología CMOS, pero la potencia dinámica puede variar según la frecuencia de operación y la capacitancia de carga. Por otro lado, para el modelo SN70LS04 se tiene una mayor disipación de potencia en comparación con CMOS debido a las corrientes de estado estático más altas.

La complejidad de la comparación entre ambos modelos puede aumentar si se tienen en cuenta sus variaciones de consumo de potencia dinámica en función de un factor de actividad (probabilidad de cambio de estado), la capacitancia de carga, el voltaje de alimentación y la frecuencia de operación. Incluso ante condiciones de operación similares, puede seguir variando cuál consuma más, debido a la afectación del CMOS a altas frecuencias.


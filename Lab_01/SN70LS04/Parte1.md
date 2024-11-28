En primer lugar se comprueba que el comportamiento de las compuertas sea el esperado, para esto se aplica una tensión en forma de onda cuadrada a **1 kHz** y se comprueba su comportamiento negador en la siguiente imagen:


Posteriormente se platea medir los intervalos de "1" y "0" lógicos usando un primer canal de una fuente DC que suministrara el nivel de voltaje de alimentación en los pines _VCC _y _GND_.  Para la señal se usara otro canal de la fuente DC que ira variando de **0V a 5V0**  y a su vez los pines correspondientes del inversor (**1A  /  1Y**) se conectara una resistencia de 0.977 kOhm en el pin de salida *1Y* donde se sabe que la corriente debera con la siguiente proporcion : 


![[Pasted image 20241128144020.png]]

Por lo mismo, se medirá el voltaje de la resistencia para conocer el voltaje en diferentes momentos de voltaje y asi estimar el intervalo:

| Vcc     | V1a     | Vr      | Iout  |
| ------- | ------- | ------- | ----- |
| 4.995 V | 5V      | 0.4 mV  | 0     |
| 4.990 V | 4.742 V | 0.4 mV  |       |
| 5V      | 4 V     | 0.4 mV  |       |
| 4.990 V | 3.498 V | 0.5 mV  |       |
| 4.992V  | 3.096 V | 0.6 mV  |       |
| 4.989 V | 3.001 V | 0.6 mV  | 600mA |
| 4.989 V | 2.956 V | 2.290 V | 2 mA  |
|         | 2.49 V  | 2.444 V |       |
| 4.990 V | 2.2 V   | 2.926 V |       |
|         | 2.1 V   | 4.880 V |       |
|         | 1.895 V | 4.876 V |       |


En el caso del TTL, se obtuvo que:





---

[Volver](https://github.com/juamorenogo/Digital_2024_2/tree/main/Lab_01/SN70LS04)

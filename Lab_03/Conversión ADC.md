![](Imagenes/Pasted_image_20250306114408.png)

La etapa analógica (cuya entrada es la señal que varía de 0V a 5.2V) entra por la entrada IN3. Para esto, se indica por medio de los pines ADD A, ADD B y ADD C que esta entrada, colocándolos respectivamente en L, H, H. 

El clock, para un funcionamiento adecuado, se seteó a 10kHz.

Start se puso en corto con EOC, puesto que Start indica el inicio de pulso de inicio de conversión y la salida EOC indica el fin de la conversión. Como debe operar de forma continua la medición, se unen.

ALE se ajusta por medio del código en verilog para habilitar el latch de dirección antes del set en Start.

Se une la tierra del ADC con la de la FPGA, se alimenta VCC con 5V y se ajustan las referencias de VERF(+) con los 5.2V dados y VREF(-) con 0V, ya para indicar finalmente el rango completo de medición.

Los pines de $2^n$ se conectan a las entradas del FPGA, ya que son la representación binaria del número a medir y los demás pines del ADC se dejan flotantes.

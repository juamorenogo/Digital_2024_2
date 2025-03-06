Se solicita hacer una máquina de estados que cumpla una función en el proyecto e implementarla en verilog para este. 

Se muestra el diagrama de bloques para el proyecto:

![](Imagenes/Imagen_de_WhatsApp.jpg)

Dicha imagen muestra los diferentes módulos de verilog a través de los cuales se mueven entradas y salidas para mostrar en una display LCD 20x4 la encriptación, desencriptación y palabra base de un código morse.

Se escoge emplear una máquina de estados en los módulos de **line_write** y **clean**, pues ambos requieren de una visualización en la LCD.

A continuacion se presenta el funcionamiento practico del modulo:

![](Imagenes/Pasted%20image%2020250306174801.png)

![](../Pasted%20image%2020250306174825.png)

Asi mismo, se muestran videos del funcionamiento. El primero refleja usando leds, los diferentes cambios en cada pin que permitiran la correcta configuracion del LCD:

![](https://youtu.be/bNidXW4C4l0)




## SN 70LS04

### Preparación
En primer lugar se realiza la búsqueda de los diferentes valores para cada parámetro establecidos por el fabricante y  a su vez una descripción detallada del funcionamiento del **IC**. (Todos los datos recopilados se encuentran en la carpeta [Datasheets](https://github.com/juamorenogo/Digital_2024_2/tree/1c44c5a6ecf68e097588859868e095a7c471f29c/Datasheets/Lab_01).

Se establece se establece la relación entre los diferentes pines, tal como se muestra en la siguiente imagen:

	nA --> Input
	nY --> Output

![](Imagenes/Im2.png)

Cada par de terminales relacionados por _nA_ y _nY_ representa un inversor.

![](Imagenes/Im3.png)

Por otro lado, se obtienen los datos típicos dados por el fabricante para diferentes parámetros:

![](Imagenes/Im1.png)

---
### Simulación
Para simular el comportamiento se usaron los modelos _SPICE_ obtenidos desde la siguiente referencia:

* ([2024-2/labs/lab01/spice at main · digital-electronics-UNAL/2024-2](https://github.com/digital-electronics-UNAL/2024-2/tree/main/labs/lab01/spice))

En primer lugar se realiza un montaje de prueba del circuito, donde se plantea visualizar si cumple con el comportamiento básico esperado de compuerta *NOT / Negador / Inversor*.

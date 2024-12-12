## Fan-IN/OUT

En la sección de! se explica este concepto. Un **montaje experimental** totalmente confiable, requeriría la compra de multitud de integrados (cosa que no es posible) para determinar físicamente hasta que punto la corriente dada a los demás integrados permite un adecuado trabajo, por lo anterior, se propone realizarlo vía **simulación**:
### Fan-OUT
En este caso para simular el _Fan-OUT_ en un primer momento se ponen **40** compuertas, sin embargo, el modelo permitió seguir operando de manera prácticamente perfecta, debido a que la carga puesta era muy grande. También se le atribuye esto a la simplicidad del modelo inversor.



Posteriormente se aumenta la frecuencia de la Onda y se pone cargas mucho mas pequeñas, esto permite obtener que para **f=500 kHz** a una carga de 100Ohms se tiene ya distorsiones en la onda y a su vez los valores obtenidos de voltaje entrarían en el rango del "0 Logico", por lo que, aunque en la simulación siga funcionando, en un montaje experimental, a las **8 compuertas dejaría de cumplir su función en estas condiciones. **



### Fan-IN

El **Fan-in** en este caso es simple, debido a que solo tiene una única entrada, por lo que, se asume que en este caso es 1 únicamente.

---

[Volver](https://github.com/juamorenogo/Digital_2024_2/tree/main/Lab_01/SN70LS04)
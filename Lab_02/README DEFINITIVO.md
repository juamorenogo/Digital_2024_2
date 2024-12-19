
![](Imagenes/Pasted%20image%2020241218200428.png)

| $R$ | $B$ | $S$ | $E$ | $Energia$ | $IBB$ | $IRD$ | $IS$ | $1_B$ | $1_S$ | $1_R$ |
|-----|-----|-----|-----|-----------|-------|-------|------|-------|-------|-------|
|  0  |  0  |  0  |  0  |     0     |   0   |   0   |   0  |   0   |   0   |   0   |
|  0  |  0  |  0  |  1  |     0     |   0   |   0   |   0  |   0   |   0   |   0   |
|  0  |  0  |  1  |  0  |     1     |   0   |   0   |   1  |   0   |   1   |   0   |
|  0  |  0  |  1  |  1  |     0     |   0   |   0   |   1  |   0   |   1   |   0   |
|  0  |  1  |  0  |  0  |     1     |   1   |   0   |   0  |   1   |   0   |   0   |
|  0  |  1  |  0  |  1  |     0     |   1   |   0   |   0  |   1   |   0   |   0   |
|  0  |  1  |  1  |  0  |     1     |   1   |   0   |   1  |   0   |   1   |   0   |
|  0  |  1  |  1  |  1  |     0     |   1   |   0   |   1  |   0   |   1   |   0   |
|  1  |  0  |  0  |  0  |     1     |   0   |   1   |   0  |   0   |   0   |   1   |
|  1  |  0  |  0  |  1  |     0     |   0   |   1   |   0  |   0   |   0   |   1   |
|  1  |  0  |  1  |  0  |     1     |   0   |   1   |   1  |   0   |   0   |   1   |
|  1  |  0  |  1  |  1  |     0     |   0   |   1   |   1  |   0   |   0   |   1   |
|  1  |  1  |  0  |  0  |     1     |   1   |   1   |   0  |   0   |   0   |   1   |
|  1  |  1  |  0  |  1  |     0     |   1   |   1   |   0  |   0   |   0   |   1   |
|  1  |  1  |  1  |  0  |     1     |   1   |   1   |   1  |   0   |   0   |   1   |
|  1  |  1  |  1  |  1  |     0     |   1   |   1   |   1  |   0   |   0   |   1   |

### Entradas:

	R : Red electrica ,"1" si hay
	B : Baterias , "1" si hay
	S : Luz solar , "1" si hay 
	E: Paro de emergencia  "1" = Abierto --> No hay corriente, "0" = Cerrado --> Si hay corriente

### Salidas

	Energía : Casa energizada
	IBB : Las baterias estan cargadas y pueden suministrar energia. 
	IRB : Hay red electrica y puede suministrar energia.
	IS : Hay luz solar y puede suministrar energia. (Directamente panel solar --> casa)
	1B : Se esta usando unicamente las baterias.
	1S : Se esta usando unicamente la energia solar.
	1R : Se esta usando unicamente la red electrica directamente.

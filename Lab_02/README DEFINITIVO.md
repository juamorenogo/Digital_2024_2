| $R$ | $B$ | $S$ | $E$ | $Energia$ | $IBB$ | $IRD$ | $IS$ | $0_R/_{1B}$ |
|-----|-----|-----|-----|-----------|-------|-------|------|-------------|
|  0  |  0  |  0  |  0  |     0     |   0   |   0   |   0  |      0      |
|  0  |  0  |  0  |  1  |     0     |   0   |   0   |   0  |      0      |
|  0  |  0  |  1  |  0  |     0     |   0   |   0   |   0  |      0      |
|  0  |  0  |  1  |  1  |     0     |   0   |   0   |   1  |      0      |
|  0  |  1  |  0  |  0  |     0     |   1   |   0   |   0  |      1      |
|  0  |  1  |  0  |  1  |     1     |   1   |   0   |   0  |      1      |
|  0  |  1  |  1  |  0  |     0     |   1   |   0   |   0  |      1      |
|  0  |  1  |  1  |  1  |     1     |   1   |   0   |   1  |      1      |
|  1  |  0  |  0  |  0  |     0     |   0   |   1   |   0  |      0      |
|  1  |  0  |  0  |  1  |     1     |   0   |   1   |   0  |      0      |
|  1  |  0  |  1  |  0  |     0     |   0   |   1   |   0  |      0      |
|  1  |  0  |  1  |  1  |     1     |   0   |   1   |   1  |      0      |
|  1  |  1  |  0  |  0  |     0     |   1   |   1   |   0  |      0      |
|  1  |  1  |  0  |  1  |     1     |   1   |   1   |   0  |      0      |
|  1  |  1  |  1  |  0  |     0     |   1   |   1   |   0  |      0      |
|  1  |  1  |  1  |  1  |     1     |   1   |   1   |   1  |      0      |
### Entradas:

	R : Red electrica
	B : Baterias
	S : Luz solar 
	E: Paro de emergencia  "1" = Abierto --> No hay corriente
	"0" = Cerrado --> Si hay corriente

### Salidas

	Energía : Casa energizada
	IBB : Las baterias estan cargadas y pueden suministrar energia. 
	IRB : Hay red electrica.
	IS : Hay luz solar.
	0R/ 1B : Como solo se usara una alimentacion , en 0 se usa la red electrica unicamente y en 1 se usan las baterias unicamente.
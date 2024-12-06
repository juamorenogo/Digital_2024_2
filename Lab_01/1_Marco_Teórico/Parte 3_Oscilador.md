
### Usos

Una forma sencilla de generar relojes o frecuencias, sea cual sea el fin último (pruebas de temporización, de señales de referencia) es por medio de un anillo oscilador hecho a partir de compuertas NOT.

Funciona de la siguiente manera: al conectar un número impar de inversores en serie entre sí (con la salida del último como entrada del primero, para cumplir el ciclo), se da una retroalimentación positiva entre las compuertas causando una inversión continua del valor de la señal que viaja a través de todas estos inversores.

### Funcionamiento

Si y solo si todos las compuertas están alimentadas para su funcionamiento, se puede pensar en el inicio de la inversión de la señal desde cualquiera de los inversores, en donde se observa lo siguiente:

* Se puede considerar una entrada inicial de una primera compuerta NOT arbitraria con estado BAJO. Esto causa que la entrada de la segunda compuerta sea ALTO, para que la entrada de la tercera compuerta sea BAJO, y para cumplir el ciclo la entrada _ahora_ de la primera compuerta (realimentación) sea ALTO. 
* Como se ve, en un tiempo aproximadamente instantáneo la entrada de cualquier compuerta escogida tiene que pasar de ser ALTO a BAJO (o ALTO a BAJO), y tan pronto cambie infinitesimalmente pasará luego a BAJO a ALTO (o BAJO a ALTO). En términos de compuertas ideales, esto llevaría a una contradicción de los estados, pero en el mundo real comienzan a ocurrir estos cambios extremadamente rápidos.
* Los parámetros que determinan la forma y condiciones de estos cambios rápidos de estados se ven determinados por condiciones iniciales en el montaje justo antes de cerrar el circuito (aunque para efectos prácticos se ignora), y por los parámetros de los circuitos que representan estas compuertas lógicas (número de transistores, tipo de transistores, etc.)

Así pues, en la medida en que se da la retroalimentación positiva, el circuito nunca se estabiliza en un solo valor sino que oscila. Se puede observar que si fuera **par** el número de compuertas, entonces no se daría oscilación debido a la estabilización de todas las salidas-entradas (la retroalimentación con respecto a cualquier compuerta se daría con el mismo nivel que con el cual comenzó).

### Ventajas

Esta configuración hace que la oscilación tenga dos características muy importantes: primero, que por la simetría del circuito hay una simetría en la señal oscilante, y segundo, que haya estabilidad y una frecuencia de oscilación determinada.

La frecuencia de oscilación depende de la cantidad de compuertas en el anillo, la capacitancia y resistencia de los componentes, y las características del material semiconductor utilizado:
1. Cuantas más compuertas haya en el anillo, mayor será el número de veces que la señal se invierte antes de volver al punto de inicio. Esto aumenta el periodo de la señal, lo que hace que la frecuencia de oscilación disminuya. 
2. Las compuertas lógicas tienen una cierta **capacitancia interna** y, cuando las señales cambian de estado (de 0 a 1 o de 1 a 0), estas capacidades se cargan y descargan. La **resistencia** de los componentes (como la resistencia de salida de las compuertas y la resistencia de los cables de conexión) también influye en la rapidez con que se puede cargar o descargar la capacitancia.
3. Los semiconductores CMOS tienen una **baja corriente de fuga** y una alta **eficiencia energética**, lo que les permite operar a mayores frecuencias sin un consumo excesivo de energía. Por otro lado, los semiconductores TTL tienden a ser más rápidos debido a sus características de conmutación más rápidas, pero consumen más energía.

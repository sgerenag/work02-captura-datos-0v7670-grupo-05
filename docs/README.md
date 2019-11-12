## Integrantes: 

Mitchell Elizabeth Rodríguez Barreto
Jhohan David Contreras Aragón
Andrés Felipe Medina Medina

### Pregunta 1: Diseñar el sistema digital de captura de los pixeles de la cámara. No es necesario incluir las señales de control Xclk, pwdn y reset, estas están descritas en el top del proyecto.

El objetivo de este módulo es recibir la información que transmite la cámara (D[7:0], PCLK, VSYNC y HREF) y dar como resultado un pixel de 8 bites en formato RGB332 e indicar cuándo se debe guardar el pixel y en cuál dirección de memoria.
Teniendo en cuenta la salida de información de la cámara se creó la memoria de datos que se específicó en el trabajo anterior. Luego se determinó que las variables PCLK, VSYNC y HREF regirían cómo sería el trámite de los datos, teniendo cada una una función: 

* PCLK: Permite que el almacenamiento estuviera sincronizado a la misma velocidad a la que la cámara manda los resultados, evitando que se pierda información o que se guarde más de una vez un pixel.
* VSYNC: Esta variable indica cuando se empieza a transmitir información a la memoria. Como se ve en la imagen, esta señal cuenta con dos flancos, el primero indica el inicio y el segundo el final de la transmisión, permaneciendo apagada en el intermedio. 
**Agregar imagen**  En el código se trabajó con la señal negada con el fin de usarlo como señal de control. 
* HREF: Esta variable indica cuando se está transmitiendo la información de una línea de pixeles
	  
Después se crearon variables axiliares como:

* Color[7:0] almacenará los 8 bits enviados por la cámara.
* Data_in[7:0] guardará la información del pixel a almacenar en la memoria. Es de tamaño 8 porque el formato del pixel es 332.
* Address_in es la dirección del espacio de memoria que ocupará la información recibida. Es una variable de 15 bites que irá incrementando en 1 su valor por cada pixel almacenado.
* Contador es una variable interna de un bit que determina si la información que ha sido recibida pertenece a un HIGH byte o a un LOW Byte. De ser contador igual a 1, se guardan los bites 1, 2, 3, 5, 6 y 7
como los primeros 6 bites del Data_in, y si contador es igual a 0 se toman los bites 3 y 4 y se almacenarán en los 2 últimos bites de Data_in. AL final de esta operación contador incrementará su valor en 1 y, al ser un número binario, su valor oscilará entre
0 y 1. 
* RegWrite es la variable que indica cuando se puede almacenar Data_in en la memoria RAM. Es igual a 1 cuando se han guardado los 8 bites en Data_in y 0 en caso contrario.

Materializando lo mencionado anteriormente en código se muestra a continuación:
**Agregar imagen del código**

### Pregunta 2: Diseñar el downsampler y transmitir la información al buffer de memoria. Recuerde la memoria se ha diseñado para almacenar el pixel en formato RGB332, y almacenar 3 bit para el color Rojo y Verde y 2 bit para el color Azul. Si usted, por ejemplo, 
selecciona el formato RGB565 de la cámara debe convertir los 5 bit de rojo en 3 bit.

En el documento anterior se explicó y argumentó el formato seleccionado por nosotros, el RGB 565, por lo que la forma escogida de hacer downsampling es tomando los bits más significativos de cada color según corresponda, es decir, 
de los 5 bits para RED se toman los primeros 3, para GREEN también se tomarán también los primeros 3 y para BLUE los primeros 2 bits.

**Agregar imagen downsampling**
**Agregar diagramas funcionales y estructurales 
### Pregunta 3:

Se hizo la actualización del archivo "clk_32MHZ_to_25M_24M.v" de acuerdo a las especificaciones de la FPGA Nexys 4DDR. El código se puede ver en hdl/*****


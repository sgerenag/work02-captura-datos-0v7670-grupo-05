## Integrantes: 

Mitchell Elizabeth Rodr�guez Barreto
Jhohan David Contreras Arag�n
Andr�s Felipe Medina Medina

### Pregunta 1: Dise�ar el sistema digital de captura de los pixeles de la c�mara. No es necesario incluir las se�ales de control Xclk, pwdn y reset, estas est�n descritas en el top del proyecto.

El objetivo de este m�dulo es recibir la informaci�n que transmite la c�mara (D[7:0], PCLK, VSYNC y HREF) y dar como resultado un pixel de 8 bites en formato RGB332 e indicar cu�ndo se debe guardar el pixel y en cu�l direcci�n de memoria.
Teniendo en cuenta la salida de informaci�n de la c�mara se cre� la memoria de datos que se espec�fic� en el trabajo anterior. Luego se determin� que las variables PCLK, VSYNC y HREF regir�an c�mo ser�a el tr�mite de los datos, teniendo cada una una funci�n: 

* PCLK: Permite que el almacenamiento estuviera sincronizado a la misma velocidad a la que la c�mara manda los resultados, evitando que se pierda informaci�n o que se guarde m�s de una vez un pixel.
* VSYNC: Esta variable indica cuando se empieza a transmitir informaci�n a la memoria. Como se ve en la imagen, esta se�al cuenta con dos flancos, el primero indica el inicio y el segundo el final de la transmisi�n, permaneciendo apagada en el intermedio. 
**Agregar imagen**  En el c�digo se trabaj� con la se�al negada con el fin de usarlo como se�al de control. 
* HREF: Esta variable indica cuando se est� transmitiendo la informaci�n de una l�nea de pixeles
	  
Despu�s se crearon variables axiliares como:

* Color[7:0] almacenar� los 8 bits enviados por la c�mara.
* Data_in[7:0] guardar� la informaci�n del pixel a almacenar en la memoria. Es de tama�o 8 porque el formato del pixel es 332.
* Address_in es la direcci�n del espacio de memoria que ocupar� la informaci�n recibida. Es una variable de 15 bites que ir� incrementando en 1 su valor por cada pixel almacenado.
* Contador es una variable interna de un bit que determina si la informaci�n que ha sido recibida pertenece a un HIGH byte o a un LOW Byte. De ser contador igual a 1, se guardan los bites 1, 2, 3, 5, 6 y 7
como los primeros 6 bites del Data_in, y si contador es igual a 0 se toman los bites 3 y 4 y se almacenar�n en los 2 �ltimos bites de Data_in. AL final de esta operaci�n contador incrementar� su valor en 1 y, al ser un n�mero binario, su valor oscilar� entre
0 y 1. 
* RegWrite es la variable que indica cuando se puede almacenar Data_in en la memoria RAM. Es igual a 1 cuando se han guardado los 8 bites en Data_in y 0 en caso contrario.

Materializando lo mencionado anteriormente en c�digo se muestra a continuaci�n:
**Agregar imagen del c�digo**

### Pregunta 2: Dise�ar el downsampler y transmitir la informaci�n al buffer de memoria. Recuerde la memoria se ha dise�ado para almacenar el pixel en formato RGB332, y almacenar 3 bit para el color Rojo y Verde y 2 bit para el color Azul. Si usted, por ejemplo, 
selecciona el formato RGB565 de la c�mara debe convertir los 5 bit de rojo en 3 bit.

En el documento anterior se explic� y argument� el formato seleccionado por nosotros, el RGB 565, por lo que la forma escogida de hacer downsampling es tomando los bits m�s significativos de cada color seg�n corresponda, es decir, 
de los 5 bits para RED se toman los primeros 3, para GREEN tambi�n se tomar�n tambi�n los primeros 3 y para BLUE los primeros 2 bits.

**Agregar imagen downsampling**
**Agregar diagramas funcionales y estructurales 
### Pregunta 3:

Se hizo la actualizaci�n del archivo "clk_32MHZ_to_25M_24M.v" de acuerdo a las especificaciones de la FPGA Nexys 4DDR. El c�digo se puede ver en hdl/*****


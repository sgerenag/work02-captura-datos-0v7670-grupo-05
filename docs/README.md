## Integrantes: 

Mitchell Elizabeth Rodr�guez Barreto
Jhohan David Contreras Arag�n
Andr�s Felipe Medina Medina

### Pregunta 1: Dise�ar el sistema digital de captura de los pixeles de la c�mara. No es necesario incluir las se�ales de control Xclk, pwdn y reset, estas est�n descritas en el top del proyecto.

El objetivo de este m�dulo es recibir la informaci�n que transmite la c�mara (D[7:0], PCLK, VSYNC y HREF) y usarla para crear correctamente un pixel que tenga un tama�o de 8 bits, ya que est� en formato RGB332, e indicar cu�ndo y en cu�l direcci�n de memoria se debe guardar el pixel en la memoria.
Las variables PCLK, VSYNC y HREF rigen c�mo y cuando se debe guardar la informaci�n recibida para la consolidaci�n correcta del pixel en el formato seleccionado. Una breve descripci�n de cada una de estas se�ales:  

* CAM_PCLK: Permite que el almacenamiento se realice de manera s�ncrona, es decir, a la misma velocidad a la que la c�mara manda los resultados y as� evitando que se pierda informaci�n o que se guarde m�s de una vez un pixel.
* CAM_VSYNC: Esta variable indica cuando la c�mara empieza a transmitir informaci�n al m�dulo de captura de datos. Como se ve en la imagen, esta se�al cuenta con dos flancos, el primero indica el inicio y el segundo el final de la transmisi�n, permaneciendo apagada en el intermedio. 
**Agregar imagen**  En el c�digo se trabaj� con la se�al negada con el fin de usarlo como se�al de control.  
* CAM_HREF: Esta variable indica cuando se est� transmitiendo la informaci�n de una l�nea de pixeles. 

**Agregar imagen del c�digo**

La forma de crear el pixel por medio de downsampling y luego de transmitirlo al buffer de memoria se encuentra descrita en el siguiente punto. 


### Pregunta 2: Dise�ar el downsampler y transmitir la informaci�n al buffer de memoria. Recuerde la memoria se ha dise�ado para almacenar el pixel en formato RGB332, y almacenar 3 bit para el color Rojo y Verde y 2 bit para el color Azul. Si usted, por ejemplo, 
selecciona el formato RGB565 de la c�mara debe convertir los 5 bit de rojo en 3 bit.
	  
Seg�n las variables de control mencionadas anteriormente lo indiquen, se conformar� un pixel de 8 bits y se transmitir� al buffer de memoria. Teniendo en cuenta que el formato que se configur� en la c�mara para arrojar la informaci�n del pixel es de RGB 565, es necesaria la transformaci�n
de este formato a uno RGB 332. Esto se logr� por medio de un proceso llamado downsampling, el cual consiste en la reduccion del tama�o de la informaci�n por medio de la selecci�n o truncamiento de determinados bits. En este caso la forma de realizar el proceso de downsampling fue escogiendo 
los bits m�s significativos de cada uno de los colores seg�n corresponda. Por ejemplo, el color RED viene en un formato en donde contiene 5 bits y para transformarlo al otro formato en donde s�lo cuenta con 3 bits, escogemos �nicamente los 3 bits m�s significativos; para el caso del GREEN y del BLUE escomgemos los
3 y 2 bits m�s significativos correspondientemente. Para ello se crearon variables axiliares internas:

* Color[7:0] almacenar�n los 8 bits enviados por la c�mara, en donde el m�s significativo es el que est� en la posici�n 7 y el menos en la 0. 
* data_in es la direcci�n del espacio de memoria que ocupar� la informaci�n recibida. Es una variable de 15 bites que ir� incrementando en 1 su valor por cada pixel almacenado.
* cont es una variable interna de un bit que determina si la informaci�n que ha sido recibida pertenece a un HIGH byte o a un LOW Byte. De ser contador igual a 0, se guardan los bites 1, 2, 3, 5, 6 y 7
como los primeros 6 bites del Data_in, y si contador es igual a 1 se toman los bites 3 y 4 y se almacenar�n en los 2 �ltimos bites de Data_in. Al final de esta operaci�n contador incrementar� su valor en 1 y, al ser un n�mero binario, su valor oscilar� entre
0 y 1. 
* DP_RAM_regW es la variable que indica cuando se puede almacenar Data_in en la memoria RAM. Es igual a 1 cuando se han guardado los 8 bites en Data_in y 0 en caso contrario.

Para el proceso de transmisi�n de la informaci�n siempre esta ocurriendo, as� el pixel est� terminado o no, pero la forma de evitar que se guarde un pixel err�neo es por medio de la variable DP_RAM_regW ya que esta solo es igual a 1 cuando el pixel est� totalmente
formado y 0 en caso contrario. 

Materializando lo mencionado anteriormente en el punto 1 y 2 en c�digo, en la siguiente se imagen se observa:
**Agregar imagen del c�digo**
Declaraci�n de las entradas y salidas del m�dulo y variables internas.

![Lectura1](./figs/declaraci�n.png)

**Agregar diagramas funcionales y estructurales 

### Pregunta 3: Revisar si el bloque PLL, clk_32MHZ_to_25M_24M.v (diagrama azul de la figura 1), propuesto en el bloque test_cam.v, cumple con las necesidades de reloj de entrada y salida para la plataforma utilizada. 
Recuerde el sistema requiere adem�s de los 32, 50 o 100 Mhz de entrada, generar dos se�ales de reloj de 25Mhz y 24 Mhz para la pantalla VGA y la C�mara respectivamente. En este sentido, el archivo clk_32MHZ_to_25M_24M.v 
se encuentran en el interior de la carpeta hdl/scr/PLL, se debe modificar.

Se hizo la actualizaci�n del archivo "clk_32MHZ_to_25M_24M.v" de acuerdo a las especificaciones de la FPGA Nexys 4DDR. El c�digo nuevo est� en la carpeta "cl_25_24.v" y se puede ver en /hdl/src/PLL/cl_25_24.v

En las siguientes imagenes se encuentra el paso a paso de c�mo se cre� el nuevo PLL con Clocking Wizard.

1) Una vez tenemos el proyecto abierto en ISE vamos a tools -> Core Generator. 

* *Imagen 1

2) Luego le damos doble click a "view by name" y buscamos "Clock Wizard". 

* *Imagen 2

3) Despu�s de unos segundos se abrir� el panel de control de Clock Wizard, en donde el �nico cambio a realizar es en la casilla de "Source", seleccionamos la opcion "Global Buffer" y le damos continuar.

* *Imagen 3

4) Ahora ingresamos las frecuencias de los dos relojes de salida que queremos. Primero se cambia el valor de la casilla "Output Freq (MHz) - Requested" de "CLK_OUT1" por 24.000. Para la segunda frecuencia del reloj activamos primero
el reloj 2 d�ndole click en la casilla frente a "CLK_OUT2" e ingresando la frecuencia deseada, en este caso 25.000. SIn cambiar nada m�s, le damos click a Next.

* *Imagen 4

5) En las 3 ventanas siguientes daremos next. 

* *Imagen 5
* *Imagen 6
* *Imagen 7

6) En esta �ltima ventana damos click en "Generate" y esperamos que el programa genere el c�digo.

* *Imagen 8

### Pregunta 4: Modificar el m�dulo test_cam.v para agregar las se�ales de entrada y salida necesarias para la c�mara (se�ales amarillas del diagrama).

En la imagen del c�digo actualizado (que se encuentra en ) se puede ver que entre las l�neas 37 y 47 se declararon las salidas de la c�mara. 
* Las variables CAM_D0, CAM_D1, CAM_D2, CAM_D3, CAM_D4, CAM_D5, CAM_D6 almacenan los 8 bits de los buses de datos dados por la c�mara.
* CAM_PCLK 
* CAM_HREF
* CAM_VSYNC

* *imagen del c�digo

### Pregunta 5: Instanciar el m�dulo dise�ado en el hito 1 y 2 en el m�dulo test_cam.v.

Nuestro c�digo ejecuta estas operaciones dentro del mismo m�dulo. C�mo estos ya se explicaron en la pregunta 1 y 2, se explicar� como se acopl� este m�dulo al m�dulo general test_cam.v.

En la siguiente imagen se ve como se ajustan las salidas de la c�mara a las entradas del m�dulo de captura de datos al igual que como las salidas de este m�dulo son las entradas del m�dulo buffer_ram_dp.v.

**imagen c�digo


### Pregunta 6: Implementar el proyecto completo y documentar los resultados. Recuerde adicionar el nombre de las se�ales y m�dulos en la figura 1 y registre el cambio en el archivo README.md 
  










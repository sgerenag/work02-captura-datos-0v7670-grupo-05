## Integrantes: 

Mitchell Elizabeth Rodríguez Barreto
Jhohan David Contreras Aragón
Andrés Felipe Medina Medina

* 1) Diseñar el sistema digital de captura de los pixeles de la cámara. No es necesario incluir las señales de control Xclk, pwdn y reset, estas están descritas en el top del proyecto.

Teniendo en cuenta la salida de información de la cámara se creó la memoria de datos que se específicó en el trabajo anterior. Luego se determinó que las variables PCLK, VSYNC y HREF regirían cómo sería el trámite de los datos, teniendo cada una una función: 

	* PCLK: Permite que el almacenamiento estuviera sincronizado a la misma velocidad a la que la cámara manda los resultados, evitando que se pierda información o que se guarde más de una vez un pixel.
	* VSYNC: Esta variable indica cuando se empieza a transmitir información a la memoria. Como se ve en la imagen, esta señal cuenta con dos flancos, el primero indica el inicio y el segundo el final de la transmisión, permaneciendo apagada en el intermedio. 
	**Agregar imagen**  
	* HREF: Esta variable indica cuando se está transmitiendo la información de una línea de pixeles
	  

## Integrantes: 

Mitchell Elizabeth Rodr�guez Barreto
Jhohan David Contreras Arag�n
Andr�s Felipe Medina Medina

* 1) Dise�ar el sistema digital de captura de los pixeles de la c�mara. No es necesario incluir las se�ales de control Xclk, pwdn y reset, estas est�n descritas en el top del proyecto.

Teniendo en cuenta la salida de informaci�n de la c�mara se cre� la memoria de datos que se espec�fic� en el trabajo anterior. Luego se determin� que las variables PCLK, VSYNC y HREF regir�an c�mo ser�a el tr�mite de los datos, teniendo cada una una funci�n: 

	* PCLK: Permite que el almacenamiento estuviera sincronizado a la misma velocidad a la que la c�mara manda los resultados, evitando que se pierda informaci�n o que se guarde m�s de una vez un pixel.
	* VSYNC: Esta variable indica cuando se empieza a transmitir informaci�n a la memoria. Como se ve en la imagen, esta se�al cuenta con dos flancos, el primero indica el inicio y el segundo el final de la transmisi�n, permaneciendo apagada en el intermedio. 
	**Agregar imagen**  
	* HREF: Esta variable indica cuando se est� transmitiendo la informaci�n de una l�nea de pixeles
	  

## Integrantes: 

Mitchell Elizabeth Rodr�guez Barreto
Jhohan David Contreras Arag�n
Andr�s Felipe Medina Medina

*1) Dise�ar el sistema digital de captura de los pixeles de la c�mara. No es necesario incluir las se�ales de control Xclk, pwdn y reset, estas est�n descritas en el top del proyecto.

Teniendo en cuenta la salida de informaci�n de la c�mara se cre� la memoria de datos que se espec�fic� en el trabajo anterior.
Luego, para que el sistema fuera sincrono se cre� un condicional utilizando las variables PCLK, VSYNC y HREF. 
	*PCLK: Esto con el fin de que el almacenamiento estuviera sincronizado a la misma velocidad a la que la c�mara manda los resultados, evitanto que se perdiera informaci�n o que se guardara m�s de una vez un pixel.
	*VSYNC: Esta variable se neg� ya que como se muestra en la documentaci�n inicial, tiene un rampa de subida cuando empieza a enviar el primer pixel de toda la imagen y permanece en cero hasta que se presenta 
	el siguiente flanco de subida, indicando que ya se envi� la totalidad de la informaci�n
	  
## Integrantes: 

Mitchell Elizabeth Rodríguez Barreto
Jhohan David Contreras Aragón
Andrés Felipe Medina Medina

*1) Diseñar el sistema digital de captura de los pixeles de la cámara. No es necesario incluir las señales de control Xclk, pwdn y reset, estas están descritas en el top del proyecto.

Teniendo en cuenta la salida de información de la cámara se creó la memoria de datos que se específicó en el trabajo anterior.
Luego, para que el sistema fuera sincrono se creó un condicional utilizando las variables PCLK, VSYNC y HREF. 
	*PCLK: Esto con el fin de que el almacenamiento estuviera sincronizado a la misma velocidad a la que la cámara manda los resultados, evitanto que se perdiera información o que se guardara más de una vez un pixel.
	*VSYNC: Esta variable se negó ya que como se muestra en la documentación inicial, tiene un rampa de subida cuando empieza a enviar el primer pixel de toda la imagen y permanece en cero hasta que se presenta 
	el siguiente flanco de subida, indicando que ya se envió la totalidad de la información
	  
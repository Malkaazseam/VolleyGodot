class_name AreaAfuera extends Area2D

func sumarPunto(pelota: Pelota):
	if pelota.ultimoToque == Jugadores.equipos.DERECHO:
		%Tablero.sumarPuntoIzquierda
	else:
		%Tablero.sumarPuntoDerecha

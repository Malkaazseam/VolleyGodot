class_name AreaCancha extends Area2D

enum lados {DERECHO, IZQUIERDO}

@export var lado: lados

var pelota: Pelota

func sumarPunto():
	if lado == lados.DERECHO:
		%Tablero.sumarPuntoIzquierda()
	elif lado == lados.IZQUIERDO:
		%Tablero.sumarPuntoDerecha()

class_name Tablero extends Control

var puntosIzquierda: int
var puntosDerecha: int

func _ready():
	puntosIzquierda = 0
	puntosDerecha = 0

func sumarPuntoIzquierda():
	puntosIzquierda += 1
	$PuntosIzquierda.set_text(str(puntosIzquierda))
	
func sumarPuntoDerecha():
	puntosDerecha += 1
	$PuntosDerecha.set_text(str(puntosDerecha))

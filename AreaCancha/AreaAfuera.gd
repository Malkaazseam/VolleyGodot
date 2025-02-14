class_name AreaAfuera extends Area2D

func _ready():
	body_entered.connect(_rebote)
	
func _rebote(body):
	if body is Pelota:
		if body.equipo == Jugadores.equipos.DERECHO:
			Puntuacion.sumarPuntoIzquierdo()
		else:
			Puntuacion.sumarPuntoDerecho()

extends Area2D

const ALTURA: float = 100

func _ready():
	body_entered.connect(_rebotar)
	
func _rebotar(body):
	if body is Pelota and body.altura <= ALTURA:
		body.direccion.x *= -1
	

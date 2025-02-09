extends Area2D

@export var vertical: bool

func _ready():
	body_entered.connect(_rebotar)
	
func _rebotar(body):
	print("rebota")
	if vertical:
		body.direccion.y *= -1
	else:
		body.direccion.x *= -1

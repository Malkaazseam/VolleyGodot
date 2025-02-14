class_name SpriteJugador extends Sprite2D

@export var syncPosition: float

func _process(delta: float) -> void:
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		position.y = -get_parent().altura
		syncPosition = position.y
	else:
		position.y = lerp(position.y, syncPosition, 0.5)

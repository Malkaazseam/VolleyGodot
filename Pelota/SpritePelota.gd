extends Sprite2D

func _process(delta: float) -> void:
	position.y = -get_parent().altura

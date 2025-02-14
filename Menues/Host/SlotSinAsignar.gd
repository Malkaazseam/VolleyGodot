extends TextureRect

enum jugadores {JUGADOR1 = 1, JUGADOR2 = 2, JUGADOR3 = 3, JUGADOR4 = 4}

@export var jugador: jugadores

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if jugador == data.jugador:
		return true
	else:
		return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.get_parent().remove_child(data)
	add_child(data)
	
	Jugadores.jugadoresEnPosicion -= 1
	Jugadores.posicionesActualizadas.emit()
	
	Jugadores.jugadores[data.multiplayerId]["equipo"] = 0
	Jugadores.jugadores[data.multiplayerId]["posicion"] = 0

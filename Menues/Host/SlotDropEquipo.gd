extends TextureRect

enum posiciones {UNO = 1, DOS = 2, TRES = 3, CUATRO = 4}

@export var equipo: Jugadores.equipos
@export var posicion: posiciones

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.get_parent().remove_child(data)
	add_child(data)
	
	Jugadores.jugadoresEnPosicion += 1
	Jugadores.posicionesActualizadas.emit()
	
	Jugadores.jugadores[data.multiplayerId]["equipo"] = equipo
	Jugadores.jugadores[data.multiplayerId]["posicion"] = posicion
	#Equipos.equipos[str(equipo)] = {str(posicion) : data.jugador}

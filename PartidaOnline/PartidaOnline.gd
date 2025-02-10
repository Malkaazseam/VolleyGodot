extends Node2D

func _ready():
	var index = 1
	for id in Jugadores.jugadores.keys():
		print(id)
		var jugadorNuevo: Jugador = Jugadores.jugadores[id]["jugador"]
		jugadorNuevo.name = str(id)
		jugadorNuevo.position = get_node("Spawn" + str(index)).position
		if id == 1:
			jugadorNuevo.sacando = true
		add_child(jugadorNuevo, true)
		jugadorNuevo.set_multiplayer_authority(id)
		index += 1

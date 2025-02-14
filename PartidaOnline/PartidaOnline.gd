extends Node2D

func _ready():
	multiplayer.server_disconnected.connect(_serverDisconnected)
	
	if multiplayer.is_server():
		for id in Jugadores.jugadores.keys():
			var jugadorNuevo: Jugador = Jugadores.jugadores[id]["jugador"]
			if Jugadores.jugadores.size() == 4:
				jugadorNuevo.position = get_node("Spawn" + str(Jugadores.jugadores[id]["posicion"])).position
			else:
				jugadorNuevo.position = get_node("Spawn" + str(Jugadores.jugadores[id]["posicion"] + 4)).position
			jugadorNuevo.name = str(id)
			if id == 1:
				jugadorNuevo.sacando = true
			add_child(jugadorNuevo, true)
			if Jugadores.jugadores.size() == 4:
				jugadorNuevo.setPosicion.rpc_id(id, get_node("Spawn" + str(Jugadores.jugadores[id]["posicion"])).position)
			else:
				jugadorNuevo.setPosicion.rpc_id(id, get_node("Spawn" + str(Jugadores.jugadores[id]["posicion"] + 4)).position)
			jugadorNuevo.cambiarAuth.rpc(id)

func _serverDisconnected():
	multiplayer.multiplayer_peer = null
	Jugadores.jugadores = {}
	get_tree().change_scene_to_file("res://Menues/Multiplayer/Multiplayer.tscn")

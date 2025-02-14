extends Control

var peer: ENetMultiplayerPeer

func _ready():
	$EsperandoJugadores.visible = false
	
	$Join.pressed.connect(_join)
	$Jugador1.visible = false
	$Jugador2.visible = false
	$Jugador3.visible = false
	$Jugador4.visible = false
	
	$Atras.pressed.connect(_atras)
	
	Jugadores.informacionActualizada.connect(_actualizarNombres)
	
	multiplayer.connected_to_server.connect(_connectedToServer)
	multiplayer.server_disconnected.connect(_serverDisconnected)
	
func _join():
	var nombre = $Nombre.text
	var puertoTexto = $Puerto.text
	var puerto = int(puertoTexto)
	var direccionIp = $IP.text
	
	if puertoTexto != "" and nombre != "" and direccionIp != "":
		peer = ENetMultiplayerPeer.new()
		var error = peer.create_client(direccionIp, puerto)
		if error == OK:
			multiplayer.multiplayer_peer = peer
			
			$EsperandoJugadores.visible = true
			$Nombre.editable = false
			$Puerto.editable = false
			$IP.editable = false
			
func _atras():
	Jugadores.borrarJugador(multiplayer.multiplayer_peer.get_unique_id())
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://Menues/Multiplayer/Multiplayer.tscn")
			
func _connectedToServer():
	Jugadores.actualizarInformacionJugadores.rpc_id(1, multiplayer.get_unique_id(), $Nombre.text)
	
func _serverDisconnected():
	$EsperandoJugadores.visible = false
	$Join.disabled = false
	$Nombre.editable = true
	$IP.editable = true
	$Puerto.editable = true
	
	Jugadores.jugadores = {}
	_actualizarNombres()
	
func _actualizarNombres():
	$Jugador1.visible = false
	$Jugador2.visible = false
	$Jugador3.visible = false
	$Jugador4.visible = false
	var indice = 1
	for value in Jugadores.jugadores.values():
		get_node("Jugador" + str(indice)).set_text(value["nombre"])
		get_node("Jugador" + str(indice)).visible = true
		indice += 1

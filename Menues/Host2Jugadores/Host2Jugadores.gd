extends Control

var peer: ENetMultiplayerPeer
var jugadoresDrag: Array
var slotsSinAsignar: Array 
var cantJugadores: int

func _ready():
	jugadoresDrag = [
		%Jugador1,
		%Jugador2
	]
	
	slotsSinAsignar = [
		%SlotSinAsignar1,
		%SlotSinAsignar2
	]
	
	%Jugador1.visible = false
	%Jugador2.visible = false
	
	$Comenzar.disabled = true
	
	Jugadores.informacionActualizada.connect(_actualizarJugadoresDrag)
	Jugadores.posicionesActualizadas.connect(_actualizarComenzar)
	
	$Host.pressed.connect(_host)
	$Comenzar.pressed.connect(_comenzar)
	$Atras.pressed.connect(_atras)
	
	multiplayer.peer_connected.connect(_peerConnected)
	multiplayer.peer_disconnected.connect(_peerDisconnected)
	
	cantJugadores = 1
	
	%Jugador1.multiplayerId = multiplayer.get_unique_id()
	
func _host():
	var puertoTexto = $Puerto.text
	var puerto = int(puertoTexto)
	var nombre = $Nombre.text
	
	if puertoTexto != "" and nombre != "":
		peer = ENetMultiplayerPeer.new()
		var error = peer.create_server(puerto, 2)
		if error == OK:
			multiplayer.multiplayer_peer = peer
			
			Jugadores.actualizarInformacionJugadores(1, nombre)
			
			$Host.disabled = true
			$Nombre.editable = false
			$Puerto.editable = false
		
func _comenzar():
	Manager.iniciarPartida.rpc()

func _atras():
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://Menues/Multiplayer/Multiplayer.tscn")
	
func _peerConnected(id):
	if multiplayer.is_server():
		for i in Jugadores.jugadores.keys():
			Jugadores.actualizarInformacionJugadores.rpc_id(id, i, Jugadores.jugadores[i]["nombre"])

func _peerDisconnected(id):
	Jugadores.borrarJugador(id)
	if multiplayer.is_server():
		Jugadores.borrarJugador.rpc(id)

func _actualizarJugadoresDrag():
	for jugador in jugadoresDrag:
		jugador.visible = false
		if jugador.multiplayerId == 0:
			jugador.get_parent().remove_child(jugador)
			slotsSinAsignar[jugador.jugador - 1].add_child(jugador)
	
	var indice = 0
	for id in Jugadores.jugadores.keys():
		jugadoresDrag[indice].setNombre(Jugadores.jugadores[id]["nombre"])
		jugadoresDrag[indice].multiplayerId = id
		jugadoresDrag[indice].visible = true
		indice += 1

func _actualizarComenzar():
	if Jugadores.jugadoresEnPosicion == 2:
		$Comenzar.disabled = false
	else:
		$Comenzar.disabled = true

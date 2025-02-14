extends Control

var peer: ENetMultiplayerPeer

var cargando: bool
const ESCENA_ONLINE: String = "res://PartidaOnline/PartidaOnline.tscn"

func _ready():
	$Host.pressed.connect(_host)
	$Join.pressed.connect(_join)
	$Start.pressed.connect(_start)
	
	multiplayer.peer_connected.connect(_peerConnected)
	multiplayer.connected_to_server.connect(_connectedToServer)
	
	$Start.disabled = true
	
func _host():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(135, 4)
	multiplayer.multiplayer_peer = peer
	
	actualizarInformacionJugadores(1)
	
	$Join.disabled = true
	$Host.disabled = true
	$Start.disabled = false
	
func _join():
	peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 135)
	multiplayer.multiplayer_peer = peer
	
	$Join.disabled = true
	$Host.disabled = true

func _start():
	_empezarPartida.rpc()
	
func _peerConnected(id):
	pass
	
func _connectedToServer():
	actualizarInformacionJugadores.rpc_id(1, multiplayer.get_unique_id())
	
@rpc("any_peer", "call_local")
func _empezarPartida():
	#esto se hace asi porque si no no le da tiempo a cargar el spawner
	#y por alguna razon se desincroniza todo y se rompe
	#lo que hace es cargar la escena en otro hilo
	cargando = true
	$Start.text = "Cargando"
	$Start.disabled = true
	ResourceLoader.load_threaded_request(ESCENA_ONLINE)

@rpc("any_peer", "call_remote")
func actualizarInformacionJugadores(id):
	var jugadorNuevo = load("res://Jugador/Jugador.tscn").instantiate()
	Jugadores.jugadores[id] = {
		"nombre" : "",
		"jugador" : jugadorNuevo
	}

func _process(delta):
	if cargando:
		if ResourceLoader.load_threaded_get_status(ESCENA_ONLINE, []):
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(ESCENA_ONLINE))

class_name JugadorState

var jugador: Jugador

func _init(jugadorNuevo):
	jugador = jugadorNuevo

func process(delta):
	jugador.direccion = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo").normalized()

func input(event: InputEvent):
	if event.is_action_pressed("Pegar"):
		if jugador.multiplayer.is_server():
			jugador.areaGolpe.pegar()
		else:
			jugador.areaGolpe.pegar.rpc_id(1)

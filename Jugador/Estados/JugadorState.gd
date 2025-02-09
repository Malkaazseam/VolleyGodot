class_name JugadorState

var jugador: Jugador

func _init(jugadorNuevo):
	jugador = jugadorNuevo

func process(delta):
	jugador.direccion = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo").normalized()

func input(event: InputEvent):
	if event.is_action_pressed("Pegar"):
		jugador.areaGolpe.pegar()

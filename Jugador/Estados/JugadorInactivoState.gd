class_name JugadorInactivoState extends JugadorState

func _init(jugadorNuevo):
	super(jugadorNuevo)
	
func process(delta):
	super(delta)
	if jugador.direccion != Vector2.ZERO:
		jugador.cambiarEstadoMoviendose()

func input(event):
	super(event)
	if event.is_action_pressed("Saltar"):
		jugador.cambiarEstadoSaltando()

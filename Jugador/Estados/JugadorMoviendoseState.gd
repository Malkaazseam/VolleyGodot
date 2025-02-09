class_name JugadorMoviendoseState extends JugadorState

func _init(jugadorNuevo):
	super(jugadorNuevo)
	
func process(delta):
	super(delta)
	if jugador.direccion == Vector2.ZERO:
		jugador.cambiarEstadoInactivo()
	else:
		var velocidad = jugador.direccion * jugador.RAPIDEZ_MOVIENDOSE * delta
		jugador.move_and_collide(Vector2(velocidad.x, 0))
		jugador.move_and_collide(Vector2(0, velocidad.y))

func input(event):
	super(event)
	if event.is_action_pressed("Tirarse"):
		jugador.cambiarEstadoTirandose()

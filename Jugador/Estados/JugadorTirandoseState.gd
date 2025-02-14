class_name JugadorTirandoseState extends JugadorState

const SEGUNDOS_TIRANDOSE: float = 0.15
var segundosRestantes: float

func _init(jugadorNuevo):
	super(jugadorNuevo)
	
	segundosRestantes = SEGUNDOS_TIRANDOSE
	
func process(delta):
	if segundosRestantes <= 0:
		jugador.cambiarEstadoTirado()
	else:
		var velocidad = jugador.direccion * jugador.RAPIDEZ_TIRANDOSE * delta
		jugador.move_and_collide(Vector2(velocidad.x, 0))
		jugador.move_and_collide(Vector2(0, velocidad.y))
		segundosRestantes -= delta
		
		jugador.syncPosition = jugador.position

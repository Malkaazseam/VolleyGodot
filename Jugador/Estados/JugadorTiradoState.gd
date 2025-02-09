class_name JugadorTiradoState extends JugadorState

const SEGUNDOS_TIRADO: float = 0.25
var segundosRestantes: float

func _init(jugadorNuevo):
	super(jugadorNuevo)
	
	jugador.areaGolpeTirandose.pegar()
	segundosRestantes = SEGUNDOS_TIRADO
	
func process(delta):
	#podria hacer que se quede tirado hasta que te muevas despues de un tiempo
	if segundosRestantes <= 0:
		jugador.cambiarEstadoInactivo()
	else:
		segundosRestantes -= delta
		
func input(event: InputEvent):
	#capas hacer un efecto de que no puede hacer nada
	pass

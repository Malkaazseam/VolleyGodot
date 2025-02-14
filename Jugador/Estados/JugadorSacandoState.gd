class_name JugadorSacandoState extends JugadorState

const ANGULO_MINIMO: float = -2 * PI / 8
const ANGULO_MAXIMO: float = 2 * PI / 8
const ESCALA_ROTACION: float = 0.025

var pelota: Pelota

func _init(jugadorNuevo):
	super(jugadorNuevo)
	
	pelota = load("res://Pelota/Pelota.tscn").instantiate()
	pelota.position = jugador.position
	pelota.syncPosition = jugador.position
	pelota.name = "Pelota"
	jugador.get_parent().add_child.call_deferred(pelota, true)
	
	jugador.flechaSaque.visible = true
	
func process(delta):
	super(delta)
	jugador.flechaSaque.rotation += jugador.direccion.y * ESCALA_ROTACION
	if jugador.flechaSaque.rotation >= ANGULO_MAXIMO:
		jugador.flechaSaque.rotation = ANGULO_MAXIMO
	if jugador.flechaSaque.rotation <= ANGULO_MINIMO:
		jugador.flechaSaque.rotation = ANGULO_MINIMO
		
func input(event: InputEvent):
	if event.is_action_pressed("Pegar"):
		#esto va a ser asi hasta que le ponga que cargue la fuerza del saque
		pelota.direccion = Vector2.RIGHT.rotated(jugador.flechaSaque.rotation) * jugador.FUERZA_SAQUE
		pelota.rapidezVertical = jugador.RAPIDEZ_VERTICAL_SAQUE
		pelota.sacada = true
		jugador.flechaSaque.visible = false
		jugador.cambiarEstadoInactivo()

class_name JugadorSaltandoState extends JugadorState

var direccionSalto: Vector2

func _init(jugadorNuevo):
	super(jugadorNuevo)

	jugador.rapidezVertical = jugador.FUERZA_SALTO
	direccionSalto = jugador.direccion
	
func process(delta):
	super(delta)
	##jugador.sprite.position.y = -jugador.altura
		
	jugador.altura += jugador.rapidezVertical * delta
	jugador.rapidezVertical -= jugador.GRAVEDAD * delta
	
	if jugador.altura <= 0:
		jugador.altura = 0
		#jugador.sprite.position.y = -jugador.altura
		jugador.rapidezVertical = 0
		jugador.cambiarEstadoInactivo()
	
	var velocidad = direccionSalto * jugador.RAPIDEZ_SALTANDO * delta
	if (velocidad.x > 0 and jugador.direccion.x < 0 or
		velocidad.x < 0 and jugador.direccion.x > 0):
		velocidad.x += jugador.direccion.x * jugador.CONTROL_AEREO * delta
	elif velocidad.x == 0 and jugador.direccion.x != 0:
		velocidad.x += jugador.direccion.x * jugador.CONTROL_AEREO_ESTATICO * delta
	if (velocidad.y > 0 and jugador.direccion.y < 0 or
		velocidad.y < 0 and jugador.direccion.y > 0):
		velocidad.y += jugador.direccion.y * jugador.CONTROL_AEREO * delta
	elif velocidad.y == 0 and jugador.direccion.y != 0:
		velocidad.y += jugador.direccion.y * jugador.CONTROL_AEREO_ESTATICO * delta

	jugador.move_and_collide(Vector2(velocidad.x, 0))
	jugador.move_and_collide(Vector2(0, velocidad.y))
	
	jugador.syncPosition = jugador.position
	
func input(event: InputEvent):
	if event.is_action_pressed("Pegar"):
		if jugador.multiplayer.is_server():
			jugador.areaGolpeSaltando.pegar()
		else:
			jugador.areaGolpeSaltando.pegar.rpc_id(1)

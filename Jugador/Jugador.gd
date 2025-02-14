class_name Jugador extends CharacterBody2D

var estado: JugadorState

const RAPIDEZ_MOVIENDOSE: float = 400
const RAPIDEZ_TIRANDOSE: float = 650
const RAPIDEZ_SALTANDO: float = 200
const CONTROL_AEREO: float = 100
const CONTROL_AEREO_ESTATICO: float = 150

var direccion: Vector2
var altura: float
const FUERZA_SALTO: float = 350
var rapidezVertical: float
const GRAVEDAD: float = 550

var areaGolpe: Area2D
var areaGolpeTirandose: Area2D
var areaGolpeSaltando: Area2D
var sprite: Sprite2D

var flechaSaque: Node2D
#esto va a ser un const hasta que ponga que cargue el saque
const FUERZA_SAQUE: float = 17
const RAPIDEZ_VERTICAL_SAQUE: float = 500

@export var sacando: bool

var syncPosition: Vector2

@export var equipo: Jugadores.equipos

func _ready():
	areaGolpe = $AreaGolpe
	areaGolpeTirandose = $AreaGolpeTirandose
	areaGolpeSaltando = $AreaGolpeSaltando
	flechaSaque = $PuntoDeRotacion
	sprite = $Sprite
	
	altura = 0
	
	if sacando:
		cambiarEstadoSacando()
	else:
		cambiarEstadoInactivo()

func _physics_process(delta: float) -> void:
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		estado.process(delta)
	else:
		position = position.lerp(syncPosition, 0.5)
		
	
func _input(event: InputEvent) -> void: 
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		estado.input(event)
	
func cambiarEstadoInactivo():
	estado = JugadorInactivoState.new(self)

func cambiarEstadoMoviendose():
	estado = JugadorMoviendoseState.new(self)

func cambiarEstadoTirandose():
	estado = JugadorTirandoseState.new(self)
	
func cambiarEstadoTirado():
	estado = JugadorTiradoState.new(self)

func cambiarEstadoSacando():
	estado = JugadorSacandoState.new(self)
	
func cambiarEstadoSaltando():
	estado = JugadorSaltandoState.new(self)

@rpc("any_peer", "call_local")
func cambiarAuth(id):
	set_multiplayer_authority(id)

@rpc("authority", "call_local")
func setPosicion(posicion):
	position = posicion
	syncPosition = posicion
	
@rpc("authority", "call_local")
func setEquipo(equipoNuevo: Jugadores.equipos):
	equipo = equipoNuevo

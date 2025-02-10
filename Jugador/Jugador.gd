class_name Jugador extends CharacterBody2D

var estado: JugadorState

const RAPIDEZ_MOVIENDOSE: float = 250
const RAPIDEZ_TIRANDOSE: float = 450

var direccion: Vector2

var areaGolpe: Area2D
var areaGolpeTirandose: Area2D

var flechaSaque: Node2D
#esto va a ser un const hasta que ponga que cargue el saque
const FUERZA_SAQUE: float = 15
const RAPIDEZ_VERTICAL_SAQUE: float = 250

var sacando: bool

func _ready():
	set_multiplayer_authority(int(str(name)))
	
	areaGolpe = $AreaGolpe
	areaGolpeTirandose = $AreaGolpeTirandose
	flechaSaque = $PuntoDeRotacion
	
	if sacando:
		cambiarEstadoSacando()
	else:
		cambiarEstadoInactivo()
	
func _physics_process(delta: float) -> void:
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		estado.process(delta)
	
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

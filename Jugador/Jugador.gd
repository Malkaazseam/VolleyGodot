class_name Jugador extends CharacterBody2D

var estado: JugadorState

const RAPIDEZ_MOVIENDOSE: float = 250
const RAPIDEZ_TIRANDOSE: float = 450

var direccion: Vector2

var areaGolpe: Area2D
var areaGolpeTirandose: Area2D

var flechaSaque: Node2D
#esto va a ser un const hasta que ponga que cargue el saque
const FUERZA_SAQUE: float = 10

func _ready():
	areaGolpe = $AreaGolpe
	areaGolpeTirandose = $AreaGolpeTirandose
	flechaSaque = $PuntoDeRotacion
	
	cambiarEstadoSacando()
	
func _physics_process(delta: float) -> void:
	estado.process(delta)
	
func _input(event: InputEvent) -> void: 
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

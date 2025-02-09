class_name Pelota extends RigidBody2D

var seguir: bool

var ultimaPosicion: Vector2
var direccion: Vector2
const RAPIDEZ: float = 25

const ALTURA_INICIAL: float = 0
const ALTURA_MAXIMA: float = 100
var altura: float
var rapidezVertical: float
const GRAVEDAD: float = 10

func _ready():
	altura = ALTURA_INICIAL
	
	seguir = false

func _physics_process(delta: float) -> void:
	if seguir:
		direccion = position - ultimaPosicion
		ultimaPosicion = position
		position = get_global_mouse_position()
	else:
		var velocidad = direccion * RAPIDEZ * delta
		move_and_collide(Vector2(velocidad.x, 0))
		move_and_collide(Vector2(0, velocidad.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			seguir = true
		elif not event.pressed:
			seguir = false

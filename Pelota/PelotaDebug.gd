class_name Pelota extends RigidBody2D

#debug
var seguir: bool

var areaPuntaje: Area2D

var ultimaPosicion: Vector2
var direccion: Vector2
const RAPIDEZ: float = 25
var syncPosition: Vector2

const ALTURA_INICIAL: float = 20
const ALTURA_MAXIMA: float = 100
var altura: float
var rapidezVertical: float
const GRAVEDAD: float = 550
var sacada: bool

var ultimoToque: Jugadores.equipos

var reboto: bool

func _ready():
	altura = ALTURA_INICIAL

	areaPuntaje = $AreaPuntaje

	sacada = false
	reboto = false

	#debug
	seguir = false

func _physics_process(delta: float) -> void:
	#debug (la parte de seguir)
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		if seguir:
			direccion = position - ultimaPosicion
			ultimaPosicion = position
			position = get_global_mouse_position()
		else:
			var velocidad = direccion * RAPIDEZ * delta
			move_and_collide(Vector2(velocidad.x, 0))
			move_and_collide(Vector2(0, velocidad.y))

			if sacada:
				altura += rapidezVertical * delta
				rapidezVertical -= GRAVEDAD * delta

				$Rebote.emitting = false
				if altura <= 0:
					altura = 0
					rapidezVertical *= -0.7
					direccion *= 0.7
					$Rebote.emitting = true
					reboto = true
					if areaPuntaje.has_overlapping_areas():
						for area in areaPuntaje.get_overlapping_areas():
							if area is AreaCancha:
								area.sumarPunto()
		syncPosition = position
	else:
		position = position.lerp(syncPosition, 0.5)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			seguir = true
		elif not event.pressed:
			seguir = false
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			altura -= 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			altura += 1

func setUltimoToque(equipo: Jugadores.equipos):
	ultimoToque = equipo
	$SpritePelota/Label.set_text(str(ultimoToque))

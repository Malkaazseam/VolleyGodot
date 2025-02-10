extends Area2D

const DISTANCIA: float = 15
const FUERZA_GOLPE: float = 9
const RAPIDEZ_VERTICAL: float = 750
const ALTURA_VALIDA: float = 50

const SEGUNDOS_PEGANDO: float = 0.20
var segundosRestantes: float
var pegando: bool

const SEGUNDOS_COOLDOWN: float = 0.25
var segundosRestantesCooldown: float
var cooldown: bool

var pego: bool

func _ready():
	pegando = false
	cooldown = false
	
	segundosRestantes = 0
	segundosRestantesCooldown = 0

func _process(delta):
	position = get_parent().direccion * DISTANCIA
	
	if segundosRestantes > 0:
		segundosRestantes -= delta
		_golpear()
	elif pegando:
		pegando = false
		cooldown = true
		segundosRestantesCooldown = SEGUNDOS_COOLDOWN
		
	if segundosRestantesCooldown > 0:
		segundosRestantesCooldown -= delta
	elif cooldown:
		cooldown = false
		if pego:
			pegar()

func pegar():
	if not pegando and not cooldown:
		pego = false
		pegando = true
		segundosRestantes = SEGUNDOS_PEGANDO
	elif cooldown:
		pego = true

func _golpear():
	if has_overlapping_bodies():
			for body in get_overlapping_bodies():
				if body is Pelota and body.altura <= ALTURA_VALIDA:
					body.direccion = (body.global_position - global_position).normalized() * FUERZA_GOLPE
					body.rapidezVertical = RAPIDEZ_VERTICAL
					segundosRestantes = 0
					break

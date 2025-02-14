extends Node

var jugadores: Dictionary

signal informacionActualizada
signal posicionesActualizadas

var jugadoresEnPosicion: int

enum equipos {DERECHO = 1, IZQUIERDO = 2}

func _ready():
	jugadores = {}

@rpc("any_peer", "call_remote")
func actualizarInformacionJugadores(id, nombre):
	if not jugadores.has(id):
		var jugadorNuevo = load("res://Jugador/Jugador.tscn").instantiate()
		jugadores[id] = {
			"nombre" : nombre,
			"jugador" : jugadorNuevo
		}
		informacionActualizada.emit()
		
	if multiplayer.is_server():
		actualizarInformacionJugadores.rpc(id, nombre)

@rpc("any_peer", "call_remote")
func borrarJugador(id):
	jugadores.erase(id)
	
	informacionActualizada.emit()

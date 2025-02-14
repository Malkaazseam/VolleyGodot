extends Node

var cargando: bool
const ESCENA_ONLINE: String = "res://PartidaOnline/PartidaOnline.tscn"

@rpc("authority", "call_local")
func iniciarPartida():
	cargando = true
	ResourceLoader.load_threaded_request(ESCENA_ONLINE)

func _process(delta):
	if cargando:
		if ResourceLoader.load_threaded_get_status(ESCENA_ONLINE, []):
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(ESCENA_ONLINE))

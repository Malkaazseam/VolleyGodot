extends Control

func _ready():
	$Host2Jugadores.pressed.connect(_menuHost2Jugadores)
	$Host4Jugadores.pressed.connect(_menuHost4Jugadores)
	$Join.pressed.connect(_menuJoin)
	$Salir.pressed.connect(_salir)
	
func _menuHost2Jugadores():
	get_tree().change_scene_to_file("res://Menues/Host2Jugadores/Host2Jugadores.tscn")
	
func _menuHost4Jugadores():
	get_tree().change_scene_to_file("res://Menues/Host/Host.tscn")
 
func _menuJoin():
	get_tree().change_scene_to_file("res://Menues/Join/Join.tscn")

func _salir():
	get_tree().quit()

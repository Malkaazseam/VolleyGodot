class_name JugadorDrag extends TextureRect

enum jugadores {JUGADOR1 = 1, JUGADOR2 = 2, JUGADOR3 = 3, JUGADOR4 = 4}

@export var jugador: jugadores

var multiplayerId: int

func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = Control.new()
	
	#todo este codigo de mierda es porque godot es una mierda
	#y no tiene forma facil de centrar el preview
	#no se exactamente que es lo que le hace al circulo
	#pero eso funciona para centrar el preview en el cursor
	var circulo = TextureRect.new()
	#el 70 es un numero magico
	#con ese numero queda del mismo tamaño que el circulo que clickeas
	circulo.custom_minimum_size = Vector2(70, 70)
	circulo.set_texture(texture)
	circulo.position = -0.5 * circulo.custom_minimum_size
	preview.add_child(circulo)
	
	set_drag_preview(preview)
	return self

func setNombre(nombre: String) -> void:
	$Nombre.set_text(nombre)

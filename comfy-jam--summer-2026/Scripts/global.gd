extends Node

var window_size : Vector2 = Vector2(1280,720)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().size = window_size
	get_viewport().size = window_size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

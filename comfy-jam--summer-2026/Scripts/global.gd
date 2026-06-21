extends Node
var window_size : Vector2 = Vector2(1280,720)
@onready var house_music : AudioStreamPlayer = $HouseBgm
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().size = window_size
	get_viewport().size = window_size
	start_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_music():
	await get_tree().create_timer(0.5).timeout
	#house_music.play()

extends Node2D

@onready var bg: TextureRect = $"main menu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click_button"):
		print("button")
		Signals.start_tutorial.emit()
		bg.hide()

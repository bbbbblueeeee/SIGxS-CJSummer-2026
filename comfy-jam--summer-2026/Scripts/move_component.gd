extends Node2D

@export var speed : float
var direction: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move left"):
		direction = -1
	if Input.is_action_just_pressed("move right"):
		direction = 1
	if !Input.is_action_pressed("move left") and !Input.is_action_pressed("move right"):
		direction = 0
	get_parent().position.x += (direction*speed)

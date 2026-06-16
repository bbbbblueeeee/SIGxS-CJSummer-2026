extends Node2D

@export var speed : float
var direction : int
var new_position : int
var background_offset : int
var house : Node2D
var i = 0
var left_limit : int = 580
var right_limit : int = 4350


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	house = get_parent().get_parent().get_node("House")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move left"):
		direction = -1
	if Input.is_action_just_pressed("move right"):
		direction = 1
	if Input.is_action_pressed("move left") and !Input.is_action_pressed("move right"):
		direction = -1
	if !Input.is_action_pressed("move left") and Input.is_action_pressed("move right"):
		direction = 1
	if !Input.is_action_pressed("move left") and !Input.is_action_pressed("move right"):
		direction = 0
	
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		if Input.is_action_pressed("sprint"):
			speed = 20.0
		else:
			speed = 13.0
		new_position = get_parent().position.x + direction*speed
		if new_position > right_limit:
			new_position = right_limit
		elif new_position < left_limit:
			new_position = left_limit
			if house.current_floor == 1:
				Signals.floor_transition.emit(2)
			elif house.current_floor == 2:
				Signals.floor_transition.emit(1)
		get_parent().position.x = new_position
		

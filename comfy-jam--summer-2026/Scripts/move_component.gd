extends Node2D

@export var speed : float
var direction : int
var new_position : int
var background_offset : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
		new_position = get_parent().position.x + direction*speed
		background_offset -= direction*speed
		if background_offset > -1280 and background_offset < 2560:
			if get_parent().position.x != 608:
				get_parent().position.x = new_position
				background_offset += direction*speed
			else:
				Signals.move_background.emit(background_offset)
		elif background_offset <= -1280:
			background_offset = -1280
			Signals.move_background.emit(background_offset)
			if new_position >= 1152:
				new_position = 1152 
			get_parent().position.x = new_position
		elif background_offset >= 2560:
			background_offset = 2560
			Signals.move_background.emit(background_offset)
			if new_position <= 0:
				new_position = 0
			get_parent().position.x = new_position
		

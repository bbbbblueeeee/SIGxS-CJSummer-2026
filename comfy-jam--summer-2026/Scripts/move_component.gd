extends Node2D

@export var speed : float
var direction : int
var new_position : int
var background_offset : int
var house : Node2D
var i = 0


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
		background_offset -= direction*speed
		if background_offset >= -1280 and background_offset <= 2560:
			if get_parent().position.x != 608:
				get_parent().position.x = new_position
				background_offset += direction*speed
				i+=1
				print("moving player "+ str(i))
			else:
				Signals.move_background.emit(background_offset)
				i+=1
				print("move background "+ str(i))
		elif background_offset < -1280:
			print("right edge")
			background_offset = -1280
			if new_position > 1152:
				new_position = 1152
				print("sjldfkjalsdjfka")
			get_parent().position.x = new_position
		elif background_offset > 2560:
			print("left edge")
			background_offset = 2560
			if new_position < 0:
				new_position = 0
				if house.current_floor == 1:
					Signals.change_floors.emit(2)
				elif house.current_floor == 2:
					Signals.change_floors.emit(1)
			get_parent().position.x = new_position
		

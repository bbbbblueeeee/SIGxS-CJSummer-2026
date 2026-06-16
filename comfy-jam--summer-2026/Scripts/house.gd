extends Node2D
var current_floor : int = 2
@onready var move_component : Node2D = $"../Player/MoveComponent"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ChoreManager.create_chores_list(get_parent().day)
	Signals.floor_transition.connect(change_floor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_floor(floor):
	move_component.process_mode = PROCESS_MODE_DISABLED
	await Fade.fade(1,0.5).finished
	current_floor = floor
	if floor == 1:
		$Room1.texture=load("res://Assets/Stairs_going_up.png")
		$Room2.texture=load("res://Assets/Kitchen_Room.png")
		$Room3.texture=load("res://Assets/Living_Room.png")
		$Room4.texture=load("res://Assets/Door_Leading_Outside.png")
		move_component.right_limit = 4956
	elif floor == 2:
		$Room1.texture=load("res://Assets/Stairs_going_down.png")
		$Room2.texture=load("res://Assets/Utility_Room_.png")
		$Room3.texture=load("res://Assets/Bedroom.png")
		$Room4.texture=load("res://Assets/Balcony.png")
		move_component.right_limit = 4350
	for chore in $ChoreManager.chores_array:
		if chore.floor == floor and !chore.completed:
			chore.get_node("Sprite2D").visible = true
			chore.get_node("Area2D").monitoring = true
		else:
			chore.get_node("Sprite2D").visible = false
			chore.get_node("Area2D").monitoring = false
			
	move_component.direction = 1
	await Fade.fade(0,0.5).finished
	move_component.process_mode = PROCESS_MODE_INHERIT

extends Node2D
var current_floor : int = 2
@onready var fade : CanvasLayer = $"../../GUI/Fade"
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
	await fade.fade(1,0.5).finished
	if floor == 1:
		current_floor = 1
		$Room1.texture=load("res://Assets/Temporary/Stairs_going_up_(for_pau).png")
		$Room2.texture=load("res://Assets/Temporary/Kitchen_Room_(for_pau).png")
		$Room3.texture=load("res://Assets/Living_Room.png")
		$Room4.texture=load("res://Assets/Door_Leading_Outside.png")
	elif floor == 2:
		current_floor = 2
		$Room1.texture=load("res://Assets/Temporary/Stairs_going_down_(for_pau).png")
		$Room2.texture=load("res://Assets/Temporary/Utility_Room_(for_pau).png")
		$Room3.texture=load("res://Assets/Bedroom.png")
		$Room4.texture=load("res://Assets/Balcony.png")
	move_component.direction = 1
	await fade.fade(0,0.5).finished
	move_component.process_mode = PROCESS_MODE_INHERIT

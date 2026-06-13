extends Node2D
var current_floor : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ChoreManager.create_chores_list(get_parent().day)
	Signals.move_background.connect(on_move_background)
	Signals.change_floor.connect(on_change_floor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_move_background(offset):
	$Room1.offset.x = offset
	$Room2.offset.x = offset
	$Room3.offset.x = offset
	$Room4.offset.x = offset
	$Pillars/Pillar1.offset.x = offset
	$Pillars/Pillar2.offset.x = offset
	$Pillars/Pillar3.offset.x = offset
	for chore in $ChoreManager.chores_array:
		chore.position.x = offset + chore.initial_position


func on_change_floor(floor):
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

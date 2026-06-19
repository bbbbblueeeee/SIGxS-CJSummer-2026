extends Node2D
var current_floor : int = 1
@onready var move_component : Node2D = $"../Player/MoveComponent"
@onready var chore_manager: Node2D = $ChoreManager


var floor_1_dict = [
	#format:
	#[position.x,offset.x,offset.y,texture]
	[1000,-100,-220,"Stairs_going_up_plant"],
	[3600,-100,-90,"broom"],
	[2200,-210,-40,"Kitchen_table"],
	[4260,-180,-140,"entrance_desk"],
	[1720,-170,-110,"Kitchen_sink"]
]

var floor_2_dict = [
	#format:
	#[position.x,offset.x,offset.y,texture]
	[1725,-200,-140,"Utility_laundry"],
	[2150,-175,-370,"Utility_bookshelf"],
	[4150,-255,-350,"Balcony_clothes"],
	[820,-50,-155,"Stairs_going_down_books"],
	[1385,-105,-260,"Utility_Room_watercooler"],
	[3580,-80,-450,"Bedroom_light"],
]

var floor_1_objects = []
var floor_2_objects = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.floor_transition.connect(change_floor)
	Signals.next_day.connect(new_day)
	create_objects(floor_1_dict,floor_1_objects)
	create_objects(floor_2_dict,floor_2_objects)
	new_day(0)

func new_day(day):
	clear_chores_list()
	chore_manager.create_chores_list(day)
	if day == 0:
		current_floor = 1
		for object in floor_2_objects:
			object.visible = false
	else:
		current_floor = 2
	change_floor(current_floor)

func clear_chores_list():
	for chore in chore_manager.chores_array:
		chore.queue_free()
	chore_manager.chores_array.clear()

func create_objects(object_dict, object_array):
	for object in object_dict:
		var new_object = Sprite2D.new()
		new_object.centered = false
		new_object.position.x = object[0]
		new_object.position.y = 450
		new_object.offset.x = object[1]
		new_object.offset.y = object[2]
		new_object.texture = load("res://Assets/"+object[3]+".png")
		add_child(new_object)
		object_array.append(new_object)

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
		for object in floor_1_objects:
			object.visible = true
		for object in floor_2_objects:
			object.visible = false
		$Bed/Sprite2D.visible = false
		$Bed/Area2D.monitoring = false
		$Door/Sprite2D.visible = true
		$Door/Area2D.monitoring = true
	elif floor == 2:
		$Room1.texture=load("res://Assets/Stairs_going_down.png")
		$Room2.texture=load("res://Assets/Utility_Room_.png")
		$Room3.texture=load("res://Assets/Bedroom.png")
		$Room4.texture=load("res://Assets/Balcony.png")
		move_component.right_limit = 4350
		for object in floor_1_objects:
			object.visible = false
		for object in floor_2_objects:
			object.visible = true
		$Bed/Sprite2D.visible = true
		$Bed/Area2D.monitoring = true
		$Door/Sprite2D.visible = false
		$Door/Area2D.monitoring = false
			
	for chore in $ChoreManager.chores_array:
		if chore.floor == floor and !chore.completed:
			chore.get_node("Area2D").monitoring = true
		else:
			chore.get_node("Area2D").monitoring = false
			
	move_component.direction = 1
	await Fade.fade(0,0.5).finished
	move_component.process_mode = PROCESS_MODE_INHERIT

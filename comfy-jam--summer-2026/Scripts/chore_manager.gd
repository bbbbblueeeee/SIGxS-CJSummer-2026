extends Node2D

var chores_array = []
var chores_dict = [
	#format:
	#["name",time,points,position.x,offset.x,offset.y,"filepath",scale.x,scale.y,floor]
	["take care of the plants",2,15,1000,-100,-220,"Stairs_going_up_plant",6,6,1],
	["sweep the floor",2,15,3600,-100,-90,"broom",6,6,1],
	["set the table",1,5,2200,-210,-40,"Kitchen_table",14,6,1],
	["do laundry",4,45,1725,-200,-140,"Utility_laundry",16,6,2],
	["dust the bookshelf",3,30,2150,-175,-370,"Utility_bookshelf",12,6,2],
	["organize the cabinet",2,20,4260,-180,-140,"entrance_desk",14,6,1],
	["fix my clothes",3,30,4150,-255,-350,"Balcony_clothes",20,6,2],
	["do my summer homework",5,55,820,-50,-155,"Stairs_going_down_books",4,6,2],
	["refill the water",3,30,1385,-105,-260,"Utility_Room_watercooler",6,6,2],
	["fix my bedroom light",2,15,3580,-80,-450,"Bedroom_light",6,6,2],
	["unclog the sink",4,45,1720,-170,-110,"Kitchen_sink",12,6,1]
]

var day_0_chores = [1]
var day_1_chores = [0, 1, 2, 3, 4, 9]
var day_2_chores = [0, 1, 2, 5, 6, 7]
var day_3_chores = [0, 1, 2, 8, 9, 10]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Signals.clear_chores.connect(new_day)
	pass

func new_day(day):
	for chore in chores_array:
		chore.queue_free()
	chores_array.clear()

func create_chores_list(day):
	if day==0:
		for number in day_0_chores:
			create_chore(number)
	elif day==1:
		for number in day_1_chores:
			create_chore(number)
	elif day==2:
		for number in day_2_chores:
			create_chore(number)
	elif day==3:
		for number in day_3_chores:
			create_chore(number)

func create_chore(number : int):
	var new_chore = load("res://Scenes/chore.tscn").instantiate()
	new_chore.chore_name = chores_dict[number][0]
	new_chore.time_taken = chores_dict[number][1]
	new_chore.point_value = chores_dict[number][2]
	new_chore.position.x = chores_dict[number][3]
	new_chore.get_node("Sprite2D").offset.x = chores_dict[number][4]
	new_chore.get_node("Sprite2D").offset.y = chores_dict[number][5]
	new_chore.get_node("Sprite2D").texture = load("res://Assets/"+chores_dict[number][6]+"_outline.png")
	new_chore.get_node("Area2D").scale = Vector2(chores_dict[number][7],chores_dict[number][8])
	new_chore.floor = chores_dict[number][9]
	if new_chore.floor == 2:
		new_chore.get_node("Area2D").monitoring = false
	add_child(new_chore,true)
	chores_array.append(new_chore)

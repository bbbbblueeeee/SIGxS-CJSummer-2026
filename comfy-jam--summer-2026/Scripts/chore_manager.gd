extends Node2D

var chores_array = []
var chores_dict = [
	["Take Care of Plant",1,5,100,1],
	["Sweep Floor",2,15,1000,1],
	["Set Table",1,5,2200,2],
	["Do Laundry",3,30,2600,2],
	["Dust Bookshelf",2,20,600,1],
	["Organize Cabinet",2,20,1800,2],
	["Hang Clothes",3,30,1600,1],
	["Do Summer Homework",5,55,3200,2],
	["Replace Water",3,30,4900,1],
	["Fix the Light",1,10,2800,2],
	["Unclog the Sink",3,30,4000,1]
]

var day_0_chores = [0, 1, 2]
var day_1_chores = [3, 4, 5]
var day_2_chores = [5, 6, 7]
var day_3_chores = [8, 9, 10]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	new_chore.floor = chores_dict[number][4]
	if new_chore.floor == 1:
		new_chore.get_node("Sprite2D").visible = false
		new_chore.get_node("Area2D").monitoring = false
	add_child(new_chore,true)
	chores_array.append(new_chore)

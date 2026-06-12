extends Node2D

var chores_array = []
var chores_dict = [
	["Sweep Floor",2,20,400],
	["Take Care of Plant",1,5,700],
	["Fix Bed",1,5,1000],
	["Set Table",1,5,200],
	["Do Laundry",3,30,500],
	["Dust Bookshelf",2,20,-600],
	["Organize Cabinet",2,20,1100],
	["Hang Clothes",3,30,100],
	["Do Summer Homework",5,55,300],
	["Replace Water",3,30,900],
	["Fix the Light",1,10,800],
	["Unclog the Sink",3,30,400]
]

var day_0_chores = [0, 1, 2]
var day_1_chores = [3, 4, 5]
var day_2_chores = [6, 7, 8]
var day_3_chores = [9, 10, 11]


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
	new_chore.initial_position = chores_dict[number][3]
	add_child(new_chore,true)
	chores_array.append(new_chore)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

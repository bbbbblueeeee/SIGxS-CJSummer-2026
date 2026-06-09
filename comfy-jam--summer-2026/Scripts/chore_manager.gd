extends Node2D

var chores_array = []
var chores_dict = [
	["Sweep Floor",2,20,400],
	["Take Care of Plant",1,5,700],
	["Fix Bed",1,5,1000],
	["Set Table",1,5,200],
	["Do Laundry",3,30,500],
	["Dust Bookshelf",2,20,600],
	["Organize Cabinet",2,20,1100],
	["Hang Clothes",3,30,100],
	["Do Summer Homework",5,55,300],
	["Replace Water",3,30,900],
	["Fix the Light",1,10,800],
	["Unclog the Sink",3,30,400]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.chore_completed.connect(on_chore_completed)


func create_chores_list(day):
	if day==1:
		create_chore(0)
		create_chore(1)
		create_chore(2)
	elif day==2:
		create_chore(3)
		create_chore(4)
		create_chore(5)
	elif day==3:
		create_chore(6)
		create_chore(7)
		create_chore(8)
	elif day==4:
		create_chore(9)
		create_chore(10)
		create_chore(11)

func create_chore(index :int):
	var new_chore = load("res://Scenes/chore.tscn").instantiate()
	new_chore.chore_name = chores_dict[index][0]
	new_chore.time_taken = chores_dict[index][1]
	new_chore.point_value = chores_dict[index][2]
	new_chore.position.x = chores_dict[index][3]
	add_child(new_chore,true)
	chores_array.append(new_chore)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func on_chore_completed(chore):
	chores_array.remove_at(chore.index)

extends Node2D

class_name Chore
@export var chore_name : String
@export var time_taken : int
@export var point_value : int
var index : int
var player_in_area : bool = false
var is_selected : bool = false
var completed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(4,4)
	position.y = 600
	print(chore_name)
	print("Time Taken: "+str(time_taken))
	print("Point Value: "+str(point_value))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !completed and player_in_area and !is_selected and Input.is_action_just_pressed("object interaction"):
		is_selected = true
		show_dialogue_box()
	pass

func show_dialogue_box():
	var dialogue = load("res://Scripts/chore.dialogue")
	var dialogue_box : Node = load("res://Scenes/dialogue_chore.tscn").instantiate()
	add_child(dialogue_box, true)
	dialogue_box.start(dialogue,"start")

func deselect():
	await (get_tree().create_timer(0.2).timeout)
	is_selected = false

func chore_completed():
	Signals.chore_completed.emit(self)
	completed = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_area = false

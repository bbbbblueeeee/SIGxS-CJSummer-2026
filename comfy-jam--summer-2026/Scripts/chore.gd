extends Node2D

class_name Chore
@export var chore_name : String
@export var time_taken : int
@export var point_value : int
var floor : int
#var initial_position : int useless sht
var player_in_area : bool = false
var is_selected : bool = false
var completed : bool = false
var will_end_past_ten : bool = false
var will_end_past_midnight : bool = false 
#@onready var move_component: Node = %MoveComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 450
	$Area2D.monitorable = false
	Signals.time_updated.connect(calculate_end_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !completed and player_in_area and !is_selected and Input.is_action_just_pressed("object interaction"):
		is_selected = true
		show_dialogue_box()
	elif !player_in_area:
		$Sprite2D.visible = false

func show_dialogue_box():
	var dialogue = load("res://Scripts/chore.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	#var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	#add_child(dialogue_box, true)
	
	#move_component.process_mode = Node.PROCESS_MODE_DISABLED
	#DialogueManager.dialogue_ended.connect(end_dialogue, CONNECT_ONE_SHOT)
	#dialogue_box.start(dialogue,"start")

func deselect():
	await (get_tree().create_timer(0.2).timeout)
	is_selected = false

func chore_completed():
	await Fade.fade(1,1).finished
	Signals.chore_completed.emit(self)
	completed = true
	$Sprite2D.visible = false
	await Fade.fade(0,1).finished

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_in_area = true
	if !completed:
		$Sprite2D.visible = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_area = false
	$Sprite2D.visible = false
	

func calculate_end_time(time: int) -> void:
	var end_time = time_taken + time
	if end_time > 24:
		will_end_past_midnight = true
		will_end_past_ten = true
	elif end_time > 22:
		will_end_past_midnight = false
		will_end_past_ten = true
	else:
		will_end_past_midnight = false
		will_end_past_ten = false
		
func end_dialogue(_resource: DialogueResource) -> void:
	pass#move_component.process_mode = Node.PROCESS_MODE_INHERIT

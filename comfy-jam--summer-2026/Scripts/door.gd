extends Node2D
var is_selected : bool = false
var player_in_area : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 4832
	position.y = 412


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and !is_selected and Input.is_action_just_pressed("object interaction"):
		is_selected = true
		show_dialogue_box()
	pass

func show_dialogue_box():
	var dialogue = load("res://Scripts/door.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self, get_node("../../")])
	#var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	#add_child(dialogue_box, true)
	#dialogue_box.start(dialogue,"start")
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_in_area = true
	$Sprite2D.texture = load("res://Assets/entrance_door_outline.png")

func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_area = false
	$Sprite2D.texture = load("res://Assets/entrance_door.png")
	
func deselect():
	await (get_tree().create_timer(0.2).timeout)
	is_selected = false

func trigger_cutscene(d) -> void:
	print("trigger_cutscene called with: ", d)
	Signals.play_cutscene.emit(d)
	
	
	#var path = "res://Scripts/" + loc + ".dialogue"
	#var dialogue = load(path)
	#DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])

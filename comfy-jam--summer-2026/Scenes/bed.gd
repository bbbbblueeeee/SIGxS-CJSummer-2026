extends Node2D
var is_selected : bool = false
var player_in_area : bool = false
var recorded_time : int
var textbox : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.next_day.connect(deselect)
	Signals.send_balloon.connect(on_send_balloon)
	Signals.time_updated.connect(update_recorded_time)
	$Sprite2D.visible = false
	$Area2D.monitoring = false
	recorded_time = 18 #18

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and !is_selected and Input.is_action_just_pressed("object interaction"):
		is_selected = true
		show_dialogue_box()
	pass

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func show_dialogue_box():
	var dialogue = load("res://Scripts/bed.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	#var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	#add_child(dialogue_box, true)
	#dialogue_box.start(dialogue,"start")
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_in_area = true
	$Sprite2D.texture = load("res://Assets/Bedroom_bed_outline.png")

func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_area = false
	$Sprite2D.texture = load("res://Assets/Bedroom_bed.png")
	

func deselect(day):
	await (get_tree().create_timer(0.2).timeout)
	is_selected = false

func end_day() -> void:
	Signals.day_end.emit()
	recorded_time = 8

func update_recorded_time(new_time):
	recorded_time = new_time

func can_sleep() -> bool:
	if 20 <= recorded_time:
		return true
	else:
		return false

func is_penalized() -> bool:
	if 23 <= recorded_time:
		return true
	else:
		return false

func send_minus(minus_op):
	Signals.op_deduct.emit(minus_op)

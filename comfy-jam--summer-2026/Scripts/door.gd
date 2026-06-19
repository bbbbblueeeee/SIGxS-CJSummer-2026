extends Node2D
var is_selected : bool = false
var player_in_area : bool = false
var recorded_day : int
var recorded_time : int
var did_meet_friend : bool
var can_still_meet_friend : bool
var textbox : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.time_updated.connect(update_recorded_time)
	Signals.next_day.connect(new_day)
	Signals.send_balloon.connect(on_send_balloon)
	position.x = 4832
	position.y = 412
	recorded_day = 1
	recorded_time = 12
	did_meet_friend = false
	can_still_meet_friend = true
	

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func new_day(day):
	if not did_meet_friend and day > 1:
		can_still_meet_friend = false
	did_meet_friend = false
	recorded_day = day
	recorded_time = 8
	deselect()

func update_recorded_time(new_time):
	recorded_time = new_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and !is_selected and Input.is_action_just_pressed("object interaction"):
		is_selected = true
		show_dialogue_box()
	pass

func can_leave() -> bool:
	if recorded_day == 1 and 12 <= recorded_time and recorded_time <= 14:
		return true
	elif recorded_day == 2 and 8 <= recorded_time and recorded_time <= 11:
		return true
	elif recorded_day == 3 and 20 <= recorded_time and recorded_time <= 23:
		return true
	else:
		return false

func show_dialogue_box():
	var dialogue
	if can_still_meet_friend:
		if can_leave():
			if recorded_day == 1:
				dialogue = load("res://Scripts/door_day1.dialogue")
			elif recorded_day == 2:
				dialogue = load("res://Scripts/door_day2.dialogue")
			else:
				dialogue = load("res://Scripts/door_day3.dialogue")
		else:
			dialogue = load("res://Scripts/door_default.dialogue")
	else:
		dialogue = load("res://Scripts/door_defeat.dialogue")
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

func send_minus(minus_op):
	Signals.op_deduct.emit(minus_op)
	
func send_time(added_time):
	if recorded_day == 3:
		Signals.midnight.emit()
	else:
		Signals.time_skip.emit(added_time)

func send_friend_visited(day):
	print("Sent Friend Visited: "+str(day)) # Testing
	Signals.update_friend_visited.emit(day)

func trigger_cutscene(d) -> void:
	print("trigger_cutscene called with: ", d)
	did_meet_friend = true
	Signals.play_cutscene.emit(d)
	
	
	#var path = "res://Scripts/" + loc + ".dialogue"
	#var dialogue = load(path)
	#DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])

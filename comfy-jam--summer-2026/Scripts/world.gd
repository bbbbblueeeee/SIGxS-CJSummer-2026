extends Node2D

var day : int
var points : int
var is_next_day : bool
var went_out : bool
var day_left: int
var was_friend_visited_1: bool
var was_friend_visited_2: bool
var can_friend_ending: bool
var triggered_morning_dialogue: bool = false
@onready var end_day_screen: CanvasLayer = $"EndDay Screen"
var textbox: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day = 0
	points = 0
	is_next_day = false
	went_out = false
	was_friend_visited_1 = false
	was_friend_visited_2 = false
	can_friend_ending = true
	Signals.day_end.connect(change_day)
	Signals.end_day_screen.connect(display_day_end_screen)
	Signals.update_points.connect(update_point_tracker)
	end_day_screen.update_next_day.connect(ready_for_next_day)
	Signals.morning_after.connect(went_to_friend)
	Signals.update_friend_visited.connect(update_visit)
	Signals.send_balloon.connect(on_send_balloon)
	Signals.cannot_meet_friend.connect(update_friend_ending)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_next_day and Input.is_action_just_pressed("object interaction"):
		await Fade.fade(1,0.5).finished
		Signals.clear_chores.emit()
		Signals.next_day.emit(day)
		is_next_day = false
		await Fade.fade(0,0.5).finished
		if day == 4:
			show_ending()
		else:
			calculate_morning_dialogue()
			day_left = 0

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func update_point_tracker(updated):
	points = updated

func went_to_friend(d):
	print("went_to_friend called with: ", d)
	if d == 1 or d == 2:
		went_out = true
		day_left = d
		
func show_morning_dialogue(d):
	print("show_morning_dialogue called, day_left: ", d)

func change_day() -> void:
	if day == 0:
		play_day_0_scene()
	else:
		display_day_end_screen()
	
func play_day_0_scene():
	Signals.play_cutscene.emit(day)

func display_day_end_screen():
	print("End of Day " + str(day)) # For testing
	end_day_screen.show_end_day_screen(points)
	day += 1

func ready_for_next_day():
	print("ready_for_next_day called")
	is_next_day = true

func reset_morning_dialogue():
	triggered_morning_dialogue = false

func calculate_morning_dialogue():
	print("Calculating Morning Dialogue Called!")
	if !triggered_morning_dialogue:
		triggered_morning_dialogue = true
		if day == 1:
			reset_morning_dialogue()
		elif day == 2 and was_friend_visited_1:
			var path = "res://Scripts/beach_morning.dialogue"
			var dialogue = load(path)
			DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", 
				dialogue, "start", [self])
		elif day == 3 and was_friend_visited_2:
			var path = "res://Scripts/rooftop_morning.dialogue"
			var dialogue = load(path)
			DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", 
				dialogue, "start", [self])
	
func update_visit(d):
	if d == 1:
		was_friend_visited_1 = true
	if d == 2:
		was_friend_visited_2 = true

func update_friend_ending():
	can_friend_ending = false

func show_ending():
	if can_friend_ending:
		end_day_screen.display_friend_ending()
	else:
		end_day_screen.display_kid_ending()

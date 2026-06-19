extends Node2D

var day : int
var points : int
var is_next_day : bool
var went_out : bool
var day_left: int
@onready var end_day_screen: CanvasLayer = $"EndDay Screen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day = 2
	points = 0
	is_next_day = false
	went_out = false
	Signals.day_end.connect(change_day)
	Signals.end_day_screen.connect(display_day_end_screen)
	Signals.update_points.connect(update_point_tracker)
	end_day_screen.update_next_day.connect(ready_for_next_day)
	Signals.morning_after.connect(went_to_friend)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_next_day and Input.is_action_just_pressed("object interaction"):
		await Fade.fade(1,0.5).finished
		Signals.clear_chores.emit()
		#print("It is now Day " + str(day)) # For testing
		Signals.next_day.emit(day)
		is_next_day = false
		#is_processing_next_day = false
		await Fade.fade(0,0.5).finished
		if went_out:
			show_morning_dialogue(day_left)
			await DialogueManager.dialogue_started
			await DialogueManager.dialogue_ended
			went_out = false
		day_left = 0
		pass

func update_point_tracker(updated):
	points = updated

func went_to_friend(d):
	print("went_to_friend called with: ", d)
	if d == 1 or d == 2:
		went_out = true
		day_left = d
		
func show_morning_dialogue(d):
	print("show_morning_dialogue called, day_left: ", d)
	Signals.play_morning.emit(d)

func change_day() -> void:
	if day == 0:
		play_day_0_scene()
	else:
		display_day_end_screen()
	
func play_day_0_scene():
	Signals.play_cutscene.emit(day)

func display_day_end_screen():
	print("End of Day " + str(day)) # For testing
	await Fade.fade(1,0.5).finished
	end_day_screen.show_end_day_screen(points)
	day += 1
	await Fade.fade(0,0.5).finished

func ready_for_next_day():
	print("ready_for_next_day called")
	is_next_day = true

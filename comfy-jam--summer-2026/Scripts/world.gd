extends Node2D

var day : int
var points : int
var is_next_day : bool
@onready var end_day_screen: CanvasLayer = $"EndDay Screen"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day = 0
	points = 0
	is_next_day = false
	Signals.day_end.connect(change_day)
	Signals.end_day_screen.connect(display_day_end_screen)
	Signals.update_points.connect(update_point_tracker)
	end_day_screen.update_next_day.connect(ready_for_next_day)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_next_day and Input.is_action_just_pressed("object interaction"):
		await Fade.fade(1,0.5).finished
		Signals.clear_chores.emit()
		Signals.next_day.emit(day)
		print("It is now Day " + str(day)) # For testing
		is_next_day = false
		await Fade.fade(0,0.5).finished
		pass

func update_point_tracker(updated):
	points = updated

func change_day() -> void:
	if day == 0:
		play_day_0_scene()
	
func play_day_0_scene():
	Signals.play_cutscene.emit(day)

func display_day_end_screen():
	print("End of Day " + str(day)) # For testing
	await Fade.fade(1,0.5).finished
	end_day_screen.show_end_day_screen(points)
	day += 1
	await Fade.fade(0,0.5).finished

func ready_for_next_day():
	is_next_day = true

extends Node2D
var day : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day = 0
	Signals.day_end.connect(change_day)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_day() -> void:
	if day == 0:
		play_day_0_scene()
	day += 1
	print("It is now Day " + str(day)) # For testing
	
func play_day_0_scene():
	Signals.play_cutscene.emit(day)

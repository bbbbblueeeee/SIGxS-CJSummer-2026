extends Node
signal chore_completed(chore)
signal time_updated(time)
signal change_floor(floor)
signal floor_transition(floor)
signal faded_out()
signal faded_in()
signal day_end()
signal play_cutscene(day)
signal end_day_screen()
signal update_points(point)
signal next_day(day)
signal movement_unlocked()
signal movement_locked()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

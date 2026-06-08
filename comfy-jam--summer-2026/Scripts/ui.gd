extends Control

@export var time : int
@export var points : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.chore_completed.connect(on_chore_completed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func on_chore_completed(chore):
	time += chore.time_taken
	points += chore.point_value

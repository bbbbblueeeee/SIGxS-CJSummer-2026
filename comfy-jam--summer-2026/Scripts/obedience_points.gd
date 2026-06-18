extends Node2D

@onready var points_display: Label = $points_display
@export var current_points:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.chore_completed.connect(on_chore_completed)
	current_points = 0
	points_total()

func on_chore_completed(chore):
	current_points += chore.point_value
	Signals.update_points.emit(current_points)
	points_total()

func points_total():
	points_display.text = "OP: " + str(current_points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

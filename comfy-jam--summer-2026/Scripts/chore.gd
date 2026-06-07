extends Node2D

@export var chore_name : String
@export var time_taken : int
@export var point_value : int
@export var selectable := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(chore_name)
	print("Time Taken: "+str(time_taken))
	print("Point Value: "+str(point_value))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selectable and Input.is_action_pressed("test action"):
		chore_completed()
	pass

func chore_completed():
	Signals.chore_completed.emit(self)
	selectable = false
	

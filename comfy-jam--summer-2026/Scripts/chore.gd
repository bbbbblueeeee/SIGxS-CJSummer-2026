extends Node2D

@export var chore_name : String
@export var time_taken : int
@export var point_value : int
@export var selectable := true
var player_in_area := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 500
	position.y = 300
	print(chore_name)
	print("Time Taken: "+str(time_taken))
	print("Point Value: "+str(point_value))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selectable and player_in_area and Input.is_action_pressed("object interaction"):
		chore_completed()
	pass

func chore_completed():
	Signals.chore_completed.emit(self)
	selectable = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_area = false

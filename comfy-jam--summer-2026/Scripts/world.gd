extends Node2D
var day : int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ChoreManager.create_chores_list(day)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

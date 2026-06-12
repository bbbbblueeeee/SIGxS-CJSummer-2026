extends Node2D
var floor : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ChoreManager.create_chores_list(get_parent().day)
	Signals.move_background.connect(on_move_background)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_move_background(offset):
	$Room1.offset.x = offset
	$Room2.offset.x = offset
	$Room3.offset.x = offset
	$Room4.offset.x = offset
	$Pillars/Pillar1.offset.x = offset
	$Pillars/Pillar2.offset.x = offset
	$Pillars/Pillar3.offset.x = offset
	for chore in $ChoreManager.chores_array:
		chore.position.x = offset + chore.initial_position

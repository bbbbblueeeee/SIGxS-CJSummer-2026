extends ColorRect

var move_component : Node2D
var house : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_component = get_parent().get_parent().get_node("World").get_node("Player").get_node("MoveComponent")
	house = get_parent().get_parent().get_node("World").get_node("House")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_floor_transition(floor):
	move_component.process_mode = PROCESS_MODE_DISABLED
	await self.fade_out().faded_out
	house.change_floor(floor)
	await self.fade_in().faded_in
	move_component.process_mode = PROCESS_MODE_INHERIT
	print("fade transition complete")

func fade_out():
	$FadeAnimation.play("fade")
	Signals.faded_out.emit()
	
func fade_in():
	$FadeAnimation.play_backwards("fade")
	Signals.faded_in.emit()

extends CanvasLayer

@onready var background: TextureRect = $Background
@onready var points_tally: Label = $"Points Tally"
@onready var press_enter: Label = $"Press Enter"
@onready var move_component : Node2D = $"../Player/MoveComponent"
@onready var lose: Label = $Lose
@onready var bad_ending: TextureRect = $"Bad Ending"
@onready var kid_ending: TextureRect = $"Kid Ending"
@onready var friend_ending: TextureRect = $"Friend Ending"
var textbox: TextureRect
signal update_next_day()

func _ready() -> void:
	Signals.send_balloon.connect(on_send_balloon)
	Signals.next_day.connect(new_day)
	background.position.y = 0
	background.position.x = 0
	bad_ending.position.x = 0
	bad_ending.position.y = 0
	kid_ending.position.x = 0
	kid_ending.position.y = 0
	friend_ending.position.x = 0
	friend_ending.position.y = 0
	new_day(0)

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")


func new_day(day):
	bad_ending.hide()
	kid_ending.hide()
	friend_ending.hide()
	lose.hide()
	press_enter.hide()
	hide()
	move_component.process_mode = PROCESS_MODE_INHERIT
	print("Start Move") # For Testing

func show_end_day_screen(points: int) -> void:
	move_component.process_mode = PROCESS_MODE_DISABLED
	print("Stop Move") # For Testing
	points_tally.text = "Total Obedience Points: "
	show()
	await Fade.fade(0,0.5).finished
	await get_tree().create_timer(1).timeout
	points_tally.text = "Total Obedience Points: " + str(points)
	await get_tree().create_timer(1).timeout
	if points < 0:
		display_bad_ending()
	else:
		press_enter.show()
		update_next_day.emit()

func display_bad_ending():
	bad_ending.show()
	background.hide()
	lose.show()
	await get_tree().create_timer(2).timeout
	var dialogue = load("res://Scripts/bad_ending.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	
func display_kid_ending():
	show()
	kid_ending.show()
	background.hide()
	points_tally.hide()
	await get_tree().create_timer(2).timeout
	var dialogue = load("res://Scripts/good_kid_ending.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	
func display_friend_ending():
	show()
	friend_ending.show()
	background.hide()
	points_tally.hide()
	await get_tree().create_timer(2).timeout
	var dialogue = load("res://Scripts/good_friend_ending.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	

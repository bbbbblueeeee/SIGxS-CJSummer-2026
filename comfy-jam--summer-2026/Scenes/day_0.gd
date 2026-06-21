extends Node2D
@onready var scene_1: TextureRect = $scene1
@onready var scene_2: TextureRect = $scene2
@onready var scene_3: TextureRect = $scene3
var textbox: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	Signals.play_cutscene.connect(show_cutscene)
	Signals.send_balloon.connect(on_send_balloon)
	scene_1.position.y = 0
	scene_1.position.x = 0
	scene_2.position.y = 0
	scene_2.position.x = 0

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func show_cutscene(day):
	if day == 0:
		show()
		scene_2.hide()
		scene_3.hide()
		await Fade.fade(0,0.5).finished
		show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/day0.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	
func change_scene(sceneA, sceneB):
	sceneB.show()
	sceneA.hide()
	
func change_scene_with_fade(sceneA, sceneB):
	await Fade.fade(1,0.5).finished
	sceneB.show()
	sceneA.hide()
	await Fade.fade(0,0.5).finished

func end_scene():
	await Fade.fade(1,0.5).finished
	hide()
	Signals.end_day_screen.emit()

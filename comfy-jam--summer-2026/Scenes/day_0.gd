extends Node2D
@onready var scene_1: TextureRect = $scene1
@onready var scene_2: TextureRect = $scene2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	Signals.play_cutscene.connect(show_cutscene)
	scene_1.position.y = 0
	scene_1.position.x = 0
	scene_2.position.y = 0
	scene_2.position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_cutscene(day):
	await Fade.fade(1,0.5).finished
	show()
	scene_2.hide()
	await Fade.fade(0,0.5).finished
	show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/day0.dialogue")
	var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	add_child(dialogue_box, true)
	dialogue_box.start(dialogue,"start")
	pass
	
func change_scene(sceneA, sceneB):
	sceneB.show()
	sceneA.hide()

func end_scene():
	await Fade.fade(1,0.5).finished
	hide()
	Signals.end_day_screen.emit()
	await Fade.fade(0,0.5).finished

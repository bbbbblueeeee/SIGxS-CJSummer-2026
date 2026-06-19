extends Node2D
@onready var cg: TextureRect = $cg
@onready var TEMP: TextureRect = $TEMP_rooftop
@onready var black: TextureRect = $black


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	cg.position.y = 0
	cg.position.x = 0
	Signals.play_cutscene.connect(show_cutscene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_cutscene(day):
	print(day)
	if int(day) == 3:
		await Fade.fade(1,0.5).finished
		show()
		cg.hide()
		black.hide()
		await Fade.fade(0,0.5).finished
		show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/rooftop_proper.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	pass
	
func change_scene(sceneA, sceneB):
	sceneB.show()
	sceneA.hide()
	
func change_scene_with_fade(sceneA, sceneB):
	await Fade.fade(1,0.5).finished
	sceneB.show()
	sceneA.hide()
	await Fade.fade(0,0.5).finished

func end_scene():
	# await Fade.fade(1,0.5).finished
	hide()
	Signals.end_day_screen.emit()
	await Fade.fade(0,0.5).finished
	
func show_fade(s):
	await Fade.fade(1,0.5).finished
	s.show()
	await Fade.fade(0,0.5).finished
	

extends Node2D
@onready var scene_1: TextureRect = $scene1
@onready var scene_2: TextureRect = $scene2
@onready var scene_3: TextureRect = $scene3


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
	if day == 0:
		await Fade.fade(1,0.5).finished
		show()
		scene_2.hide()
		scene_3.hide()
		await Fade.fade(0,0.5).finished
		show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/day0.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	#var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	#add_child(dialogue_box, true)
	
	#move_component.process_mode = Node.PROCESS_MODE_DISABLED
	#DialogueManager.dialogue_ended.connect(end_dialogue, CONNECT_ONE_SHOT)
	#dialogue_box.start(dialogue,"start")
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
	# await Fade.fade(0,0.5).finished
	


func _on_button_pressed() -> void:
	pass # Replace with function body.

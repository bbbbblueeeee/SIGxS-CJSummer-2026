extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	Signals.play_morning.connect(show_cutscene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_cutscene(prev):
	if prev == 1:
		show_dialogue_box("beach")
	if prev == 2:
		show_dialogue_box("rooftop")
		

func show_dialogue_box(activity):
	var path = "res://Scripts/" + activity +  "_morning.dialogue"
	var dialogue = load(path)
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
	

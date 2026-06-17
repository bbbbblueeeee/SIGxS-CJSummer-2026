extends Node2D
@onready var scene_1: TextureRect = $scene1
@onready var scene_2: TextureRect = $scene2
@onready var move_component : Node = get_node("../../Player/MoveComponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	show_cutscene(0)
	scene_1.position.y = 0
	scene_1.position.x = 0
	scene_2.position.y = 0
	scene_2.position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_cutscene(day):
	show()
	#await Fade.fade(0,0.5).finished
	show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/tutorial.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	#var dialogue_box : Node = load("res://Scenes/dialogue.tscn").instantiate()
	#add_child(dialogue_box, true)
	#dialogue_box.start(dialogue,"start")
	pass
	
func change_scene(sceneA, sceneB):
	sceneB.show()
	sceneA.hide()
	
func hide_scene(s):
	await Fade.fade(1,0.5).finished
	#s.hide()

func end_scene():
	await Fade.fade(1,0.5).finished
	hide()
	await Fade.fade(0,0.5).finished
	

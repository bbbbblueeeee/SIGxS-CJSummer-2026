extends Node2D
@onready var cg1: TextureRect = $cg1
@onready var cg2: TextureRect = $cg2
@onready var cg3: TextureRect = $cg3
@onready var cg4: TextureRect = $cg4
@onready var TEMP: TextureRect = $TEMP_rooftop
@onready var julie: AnimatedSprite2D = $JulieSprite
@onready var mae: AnimatedSprite2D = $MaeSprite
@onready var blackscreen : TextureRect = $blackscreen
@onready var door: Node2D = get_parent().get_parent().get_node("House").get_node("Door")
var moving_mae: bool = false
var mae_speed: float
var textbox: TextureRect
var new_cg: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	cg1.position.y = 0
	cg1.position.x = 0
	cg2.position.y = 0
	cg2.position.x = 0
	cg3.position.y = 0
	cg3.position.x = 0
	cg4.position.y = 0
	cg4.position.x = 0
	Signals.play_cutscene.connect(show_cutscene)
	Signals.send_balloon.connect(on_send_balloon)
	
func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func show_cutscene(day):
	if int(day) == 3:
		await Fade.fade(1,0.5).finished
		show()
		cg1.hide()
		cg2.modulate.a = 0
		cg3.modulate.a = 0
		cg4.modulate.a = 0
		blackscreen.hide()
		julie.play("idle_sad")
		julie.flip_h = true
		mae.play("walk")
		change_music("Tense_Music",1)
		await Fade.fade(0,0.5).finished
		var tween = create_tween()
		await tween.tween_property(mae,"position",Vector2(1000,400),1.0).finished
		mae.play("idle")
		await (get_tree().create_timer(1).timeout)
		show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/rooftop_proper.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	pass

func show_cg(num):
	new_cg = get_node("cg"+str(num))
	var tween = create_tween()
	tween.tween_property(new_cg,"modulate:a",1,0.7)

func change_music(new_music,duration):
	Signals.change_music.emit(new_music,duration)
	
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
	change_music("Main_Music",2)
	await Fade.fade(0,0.5).finished
	
func show_fade(s):
	await Fade.fade(1,0.5).finished
	s.show()
	await Fade.fade(0,0.5).finished
	

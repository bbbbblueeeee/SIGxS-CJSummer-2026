extends Node2D
@onready var cg: TextureRect = $cg
@onready var TEMP: TextureRect = $TEMP_beach
@onready var julie: AnimatedSprite2D = $JulieSprite
@onready var mae: AnimatedSprite2D = $MaeSprite
var moving_mae: bool = false
var mae_speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	cg.position.y = 0
	cg.position.x = 0
	Signals.play_cutscene.connect(show_cutscene)
	
	
func show_cutscene(day):
	print(day)
	if int(day) == 2:
		await Fade.fade(1,0.5).finished
		show()
		cg.hide()
		julie.play("idle_happy")
		mae.play("walk")
		await Fade.fade(0,0.5).finished
		var tween = create_tween()
		await tween.tween_property(mae,"position",Vector2(1000,400),1.0).finished
		mae.play("idle")
		await (get_tree().create_timer(1).timeout)
		julie.flip_h = true
		await (get_tree().create_timer(1).timeout)
		show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/beach_proper.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	pass

func mae_walk_away():
	var tween_2 = create_tween()
	tween_2.tween_property(mae,"position",Vector2(1500,400),1.0)
		
	
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
	Signals.end_day_screen.emit() #CHANGE THIS
	# await Fade.fade(0,0.5).finished
	
func show_fade(s):
	await Fade.fade(1,0.5).finished
	s.show()
	await Fade.fade(0,0.5).finished
	

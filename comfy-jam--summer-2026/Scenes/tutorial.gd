extends Node2D
@onready var scene_1: TextureRect = $"black screen"
@onready var scene_2: TextureRect = $rules
@onready var scene_3: TextureRect = $ph
@onready var chores: TextureRect = $chores
@onready var ddct: TextureRect = $deductions
@onready var dc: TextureRect = $"do chores"
@onready var menu: TextureRect = $"main menu"
@onready var ad_move: Label = $ad
@onready var ent: Label = $ent
@onready var black: TextureRect = $"initial_black"
@onready var player : Node = get_node("../../Player")
var textbox : TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.send_balloon.connect(on_send_balloon)
	show_cutscene.call_deferred(0)
	hide()
	scene_1.position.y = 0
	scene_1.position.x = 0
	scene_2.position.y = 0
	scene_2.position.x = 0
	scene_3.position.y = 0
	scene_3.position.x = 0

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

	
func show_cutscene(day):
	show()
	ad_move.hide()
	ent.hide()
	scene_2.hide()
	scene_3.hide()
	ddct.hide()
	dc.hide()
	chores.hide()
	menu.show()
	var tween = create_tween()
	await tween.tween_property(black,"modulate:a",0,0.5).finished
	await wait_for_click()
	menu.hide()
	show_dialogue_box()

func show_dialogue_box():
	var dialogue = load("res://Scripts/tutorial.dialogue")
	DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", dialogue, "start", [self])
	pass
	
func tutorial_completed():
	Signals.tutorial_done.emit()
	
func change_scene(sceneA, sceneB):
	sceneB.show()
	sceneA.hide()
	
func hide_scene(s):
	await Fade.fade(1,0.5).finished
	s.hide()
	await Fade.fade(0,0.5).finished

func end_scene():
	await Fade.fade(1,0.5).finished
	hide()
	await Fade.fade(0,0.5).finished
	
func move_freely(end, dir):
	if dir == "left":
		while player.position.x > end:
			await get_tree().process_frame
	else:
		while player.position.x < end:
			await get_tree().process_frame
		
func wait_for_press(key):
	if key == "enter":
		while not Input.is_key_pressed(KEY_ENTER):
			await get_tree().process_frame
			
func wait(s):
	await get_tree().create_timer(s).timeout
			
func hide_after_while(l):
	var tween = create_tween()
	tween.tween_property(l, "modulate:a", 0.0, 0.5)
	await tween.finished
	l.hide()
	l.modulate.a = 1.0
	
func wait_for_click():
	await get_tree().create_timer(0.1).timeout  # small delay to avoid instant skip
	while not Input.is_action_just_released("object interaction"):
		if Input.is_action_just_pressed("object interaction"):
			menu.texture = load("res://Assets/UI/menu_pressed.png")
		await get_tree().process_frame
	
		
	

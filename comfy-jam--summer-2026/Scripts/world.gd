extends Node2D

var day : int = 0
var points : int = 0
var is_next_day : bool = false
var visit_count: int = 0
var can_friend_ending: bool = true
var triggered_morning_dialogue: bool = false
@onready var end_day_screen: CanvasLayer = $"EndDay Screen"
var textbox: TextureRect
@onready var music: AudioStreamPlayer = $Main_Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.day_end.connect(change_day)
	Signals.end_day_screen.connect(display_day_end_screen)
	Signals.update_points.connect(update_point_tracker)
	end_day_screen.update_next_day.connect(ready_for_next_day)
	Signals.update_friend_visited.connect(update_visit)
	Signals.send_balloon.connect(on_send_balloon)
	Signals.cannot_meet_friend.connect(update_friend_ending)
	Signals.change_music.connect(on_change_music)
	await get_tree().create_timer(0.7).timeout
	music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_next_day and Input.is_action_just_pressed("object interaction"):
		await Fade.fade(1,0.5).finished
		Signals.clear_chores.emit()
		if is_next_day:
			Signals.next_day.emit(day)
		is_next_day = false
		$House.on_change_rooms("day")
		await Fade.fade(0,0.5).finished
		if day == 4:
			show_ending()
		else:
			calculate_morning_dialogue()


func on_change_music(new_song,duration):
	var tween = create_tween()
	await tween.tween_property(music,"volume_db",-80,duration).finished
	music.stop()
	music=get_node(new_song)
	if music.volume_db == -80:
		if new_song == "Main_Music":
			music.volume_db = -8
		elif new_song == "Tense_Music":
			music.volume_db = -12
		elif new_song == "Sentimental_Music":
			music.volume_db = -12
	print(music)
	music.play()

func on_send_balloon(balloon):
	textbox = balloon.get_node("Balloon").get_node("Control2").get_node("TextureRect")

func update_point_tracker(updated):
	points = updated

func change_day() -> void:
	if day == 0:
		play_day_0_scene()
	else:
		display_day_end_screen()
	
func play_day_0_scene():
	Signals.play_cutscene.emit(day)

func display_day_end_screen():
	print("End of Day " + str(day)) # For testing
	end_day_screen.show_end_day_screen(points)
	day += 1

func ready_for_next_day():
	print("ready_for_next_day called")
	is_next_day = true

func reset_morning_dialogue():
	triggered_morning_dialogue = false

func calculate_morning_dialogue():
	if !triggered_morning_dialogue:
		triggered_morning_dialogue = true
		if day == 1:
			reset_morning_dialogue()
		elif day == 2 and visit_count == 1:
			var path = "res://Scripts/beach_morning.dialogue"
			var dialogue = load(path)
			DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", 
				dialogue, "start", [self])
		elif day == 3 and visit_count == 2:
			var path = "res://Scripts/rooftop_morning.dialogue"
			var dialogue = load(path)
			DialogueManager.show_dialogue_balloon_scene("res://Scenes/dialogue.tscn", 
				dialogue, "start", [self])
	
func update_visit(d):
	visit_count = d

func update_friend_ending():
	can_friend_ending = false

func show_ending():
	if can_friend_ending:
		end_day_screen.display_friend_ending()
	else:
		end_day_screen.display_kid_ending()

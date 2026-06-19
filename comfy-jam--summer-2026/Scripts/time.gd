extends Node2D

const END_OF_DAY: int = 22
@onready var time_display: Label = $time_display
@export var current_time: int
@export var displayed_time: int
@export var time_marker: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.chore_completed.connect(on_chore_completed)
	Signals.next_day.connect(new_day)
	Signals.time_skip.connect(add_time)
	Signals.midnight.connect(set_midnight)
	new_day(0)

func new_day(day):
	if day == 0:
		current_time = 20
	else:
		current_time = 8
	calculate_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_chore_completed(chore):
	current_time += chore.time_taken
	calculate_time()
	Signals.time_updated.emit(current_time)

func add_time(t):
	current_time += t
	calculate_time()
	Signals.time_updated.emit(current_time)

func set_midnight():
	current_time = 24
	calculate_time()

func calculate_time():
	if current_time == 24:
		displayed_time = 12
		time_marker = "AM"
	elif current_time == 12:
		displayed_time = 12
		time_marker = "PM"
	elif current_time > 12:
		displayed_time = current_time - 12
		time_marker = "PM"
	else:
		displayed_time = current_time
		time_marker = "AM"
		
	time_display.text = str(displayed_time) + ":00 " + time_marker
	

extends CanvasLayer

@onready var background: TextureRect = $Background
@onready var points_tally: Label = $"Points Tally"
@onready var press_enter: Label = $"Press Enter"
@onready var lose: Label = $Lose
signal update_next_day()

func _ready() -> void:
	Signals.next_day.connect(new_day)
	background.position.y = 0
	background.position.x = 0
	new_day(0)

func new_day(day):
	lose.hide()
	press_enter.hide()
	hide()

func show_end_day_screen(points: int) -> void:
	points_tally.text = "Total Obedience Points: "
	show()
	await get_tree().create_timer(2).timeout
	points_tally.text = "Total Obedience Points: " + str(points)
	await get_tree().create_timer(1).timeout
	if points < 0:
		lose.show()
	else:
		press_enter.show()
		update_next_day.emit()

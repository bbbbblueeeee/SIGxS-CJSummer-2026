extends AnimatedSprite2D

@onready var move_component: Node2D = $MoveComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.next_day.connect(new_day)
	position.y = 300
	new_day(0)
	scale = Vector2(1.25,1.25)
	$Area2D.scale = Vector2(5,7)

func new_day(day):
	if day == 0:
		position.x = 4500 #3168
	else:
		position.x = 3500
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	calculate_direction()
	calculate_animation()

func calculate_direction() -> void:
	if move_component.direction > 0:
		flip_h = true
	elif move_component.direction < 0:
		flip_h = false


func calculate_animation() -> void:
	if move_component.direction != 0:
		play("walk")
	else:
		play("idle")

		

extends AnimatedSprite2D

@onready var move_component: Node2D = $MoveComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 100
	position.y = 300
	pass # Replace with function body.


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
		

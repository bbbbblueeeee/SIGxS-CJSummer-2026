extends Node2D

var in_area : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and in_area:
		if event.is_pressed():
			$TextureRect.texture = load("res://Assets/UI/menu_button.png")
		elif event.is_released():
			Signals.start_tutorial.emit()
			$TextureRect.hide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	in_area = false

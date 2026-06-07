extends Node

@export var total_obedience: int = 0

func show_obedience():     # For testing
	print(total_obedience)

func change_obedience(points: int):
	total_obedience += points
	

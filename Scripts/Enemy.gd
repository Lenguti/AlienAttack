extends Node2D
class_name Enemy

@export var velocity: int = 200

func _physics_process(delta):
	global_position.x -= velocity * delta

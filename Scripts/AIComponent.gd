extends Node2D
class_name AIComponent

@export var velocity: int = 200

func _physics_process(delta):
	get_parent().position.x -= velocity * delta

class_name HealthComponent
extends Node

@export var max_health: int = 10

@onready var current_health: int = max_health

func take_damage(attack: int):
	current_health -= attack
	if current_health <= 0:
		get_parent().queue_free()


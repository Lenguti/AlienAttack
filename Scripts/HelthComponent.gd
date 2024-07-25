extends Node
class_name HealthComponent

@export var MAX_HEALTH: int = 10
var current_health: int

func _ready():
	current_health = MAX_HEALTH

func take_damage(attack: int):
	current_health -= attack
	if current_health <= 0:
		get_parent().queue_free()

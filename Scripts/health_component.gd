class_name HealthComponent
extends Node

signal on_death

@export var _max_health: int = 10

@onready var _current_health: int = _max_health

func take_damage(attack: int) -> void:
	_current_health -= attack
	if _current_health <= 0:
		get_parent().queue_free()
		emit_signal("on_death")


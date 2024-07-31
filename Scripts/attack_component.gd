class_name AttackComponent
extends Node

@export var _damage: int = 2

func set_damage(damage: int) -> void:
	_damage = damage


func get_damage() -> int:
	return _damage

class_name HitboxComponent
extends Area2D

@export var _health_component: HealthComponent

func on_hit(attack: int) -> void:
	_health_component.take_damage(attack)


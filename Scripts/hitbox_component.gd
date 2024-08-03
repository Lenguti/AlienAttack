class_name HitboxComponent
extends Area2D

@export var _health_component: HealthComponent

@onready var _explosion_player = get_tree().get_root().get_node("Game/Explosion")

func on_hit(attack: int) -> void:
	if _explosion_player:
		_explosion_player.play()
	_health_component.take_damage(attack)


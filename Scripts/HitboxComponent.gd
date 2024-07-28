extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

func on_hit(attack: int):
	#get_parent().position.x += 50
	health_component.take_damage(attack)
